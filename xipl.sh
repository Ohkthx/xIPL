#!/usr/bin/env bash

WINE_PREFIX="$HOME/.wine_ultimaonline"
WINE_ARCH="win64"

UOPATCHER_CORE="./uopatcher/uopatcher/core.py"
UOPATCHER_CONFIG="./config.ini"

CLIENT_DIR="./ultimaonline/ClassicUO"
CLIENT="ClassicUO.exe"
CLIENT_CONFIG="settings.json"

# Checks to make sure WINE is installed, along with its requirements.
function install_wine
{
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Detected OS: Linux"
  elif [[ "$OSTYPE" == "cygwin"* ]]; then
    echo "Detected OS: Window (Cygwin)"
  elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "Detected OS: FreeBSD"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected OS: MacOS"
    if ! command -v brew &> /dev/null; then
      echo "  [!!] Brew is required and not installed."
      exit
    fi
  fi

  echo "[--] Check WINE and WINETRICKS installation."
  if ! command -v perl &> /dev/null; then
    echo "  [!!] Perl is required and not installed."
    exit
  elif ! command -v git &> /dev/null; then
    echo "  [!!] Git is required and not installed."
    exit
  elif ! command -v python3 &> /dev/null; then
    echo "  [!!] Python 3 (3.9.1) is required and not installed."
    exit
  fi

  if ! command -v wine &> /dev/null; then
    echo "  [!!] Wine is required and not installed."
    brew install --cask --no-quarantine gcenx/wine/wine-crossover > /dev/null 2>&1
  fi

  if ! command -v winetricks &> /dev/null; then
    echo "  [!!] Winetricks is required and not installed."
    brew install --formula gcenx/wine/winetricks > /dev/null 2>&1
  fi
  echo "[++] WINE and WINETRICKS installation good."
}

# Checks to make sure the WINETRICKS packages are installed.
function install_winetricks
{
  echo "[--] Checking WINETRICKS packages."
  PACKAGES=$(WINEPREFIX="$WINE_PREFIX" WINEARCH="$WINE_ARCH" winetricks list-installed)

  echo -e "  [--] Checking: 'dotnet48' installed."
  DOTNET48=$(echo "$PACKAGES" | grep dotnet48)
  if [ -z "$DOTNET48" ]; then
    echo -e "    [!!] 'dotnet48' is missing, installing."
    WINEPREFIX="$WINE_PREFIX" WINEARCH="$WINE_ARCH" winetricks dotnet48 > /dev/null 2>&1
  fi
  echo -e "  [++] Has: 'dotnet48' installed."

  echo -e "  [--] Checking: 'corefonts' installed."
  COREFONTS=$(echo "$PACKAGES" | grep corefonts)
  if [ -z "$COREFONTS" ]; then
    echo -e "    [!!] 'corefonts' is missing, installing."
    WINEPREFIX="$WINE_PREFIX" WINEARCH="$WINE_ARCH" winetricks corefonts > /dev/null 2>&1
  fi
  echo -e "  [++] Has: 'corefonts' installed."
  echo -e "[++] WINETRICKS packages are installed."
}

# Checks to make sure UOPatcher is installed.
function install_uopatcher
{
  echo "[--] Checking: UOPatcher installation."

  if [ ! -f "$UOPATCHER_CORE" ]; then
    echo "  [!!] UOPatcher has not been downloaded."
    git clone https://github.com/Ohkthx/uopatcher > /dev/null 2>&1

    # Create the configuration
    { cat << EOF
      [DEFAULT]
      debug = False
      skip_prompt = True
      verbose = False
      local_root = ultimaonline
      remote_root = http://patch.shadowagereborn.com
      remote_port = 2595
EOF
    } > "$UOPATCHER_CONFIG"
  fi

  echo "[++] UOPatcher installed."
}

# Validates WINEs Registry.
function patch_wine_registry
{
  echo "[--] Checking WINE Registry."

  REG_FILE="$WINE_PREFIX/user.reg"
  NEEDS_INJECT="true"

  # Replace the managed setting.
  echo "  [--] Checking if MANAGED is set."
  MANAGED_SET=$(grep -a10 "X11 Driver" "$REG_FILE" | grep "Managed")
  if [ -n "$MANAGED_SET" ]; then
    # Edit the registry to "N" if it is "Y"
    NEEDS_INJECT="false"
    echo "    [!!] Setting 'Managed Window Management' to OFF."
    perl -pi -e 's/"Managed"="Y"/"Managed"="N"/g' "$REG_FILE"
  fi
  echo "  [++] 'Managed Window Management' is correct."

  # Replace the decorated setting.
  echo "  [--] Checking if DECORATED is set."
  DECORATED_SET=$(grep -a10 "X11 Driver" "$REG_FILE" | grep "Decorated")
  if [ -n "$DECORATED_SET" ]; then
    # Edit the registry to "N" if it is "Y"
    NEEDS_INJECT="false"
    echo "    [!!] Setting 'Decorated Window Management' to OFF."
    perl -pi -e 's/"Decorated"="Y"/"Decorated"="N"/g' "$REG_FILE"
  fi
  echo "  [++] 'Decorated Window Management' is correct."

  # Add the registry additions to the end of the file.
  if [ "$NEEDS_INJECT" == "true" ]; then
    echo "  [!!] WINE Registry Injecting to: $REG_FILE"
    { echo -e "\n[Software\\Wine\\X11 Driver]"
      echo '"Managed"="N"'
      echo '"Decorated"="N"'
    } >> "$REG_FILE"
    echo "  [++] WINE Registry Injecting completed."
  fi
  echo "[++] WINE Registry checks completed."
}

# Patches the local client, installing any missing files.
function patch_client
{
  echo "[--] Patching: Client with UOPatcher."

  if [ ! -f "$UOPATCHER_CORE" ]; then
    echo "  [!!] UOPatcher has not been downloaded."
    exit
  fi

  PYTHON_EXE="python3"
  if command -v python3.11 &> /dev/null; then
    PYTHON_EXE="python3.11"
  elif command -v python3.10 &> /dev/null; then
    PYTHON_EXE="python3.10"
  elif command -v python3.9 &> /dev/null; then
    PYTHON_EXE="python3.9"
  elif command -v python3 &> /dev/null; then
    PYTHON_EXE="python3"
  elif command -v python &> /dev/null; then
    PYTHON_EXE="python"
  else
    echo "  [!!] Could not locate python installation."
    exit
  fi

  # Run the patcher.
  echo -e "\n"
  $PYTHON_EXE "$UOPATCHER_CORE"
  echo -e "\n"

  echo "[++] Client patched."
}

function launch_client
{
  echo "[++] Starting client."
  if [ ! -d "$CLIENT_DIR" ]; then
    echo "  [!!] Client directory missing, bad installation."
    exit
  fi

  cd "$CLIENT_DIR" || exit
  WINEPREFIX="$WINE_PREFIX" WINEARCH="$WINE_ARCH" wine "$CLIENT" -settings "$CLIENT_CONFIG" -force_driver 1 > /dev/null 2>&1
  echo "[++] Stopped client."
}

# Step 1: INSTALL, Ensure all files and packages are installed.
install_wine
install_winetricks
install_uopatcher

# Step 2: PATCH, Validate and modify settings/configurations and files.
patch_wine_registry
patch_client

# Step 3: LAUNCH, start the client.
launch_client
