#!/usr/bin/env bash

WINE_DIR="$HOME/.wine"

# Checks to make sure WINE is installed, along with its requirements.
function install_check_wine
{
  echo "[++] Check WINE and WINETRICKS installation."
  if ! command -v perl &> /dev/null; then
    echo "  [!!] Perl is required and not installed."
    exit
  elif ! command -v git &> /dev/null; then
    echo "  [!!] Git is required and not installed."
    exit
  elif ! command -v brew &> /dev/null; then
    echo "  [!!] Brew is required and not installed."
    exit
  fi

  if ! command -v wine &> /dev/null; then
    echo "  [!!] Wine is required and not installed."
    brew install --cask --no-quarantine gcenx/wine/wine-crossover
  fi

  if ! command -v winetricks &> /dev/null; then
    echo "  [!!] Winetricks is required and not installed."
    brew install --formula gcenx/wine/winetricks
  fi
  echo "[++] WINE and WINETRICKS installation good."
}

# Checks to make sure the WINETRICKS packages are installed.
function install_check_winetricks
{
  echo "[--] Checking WINETRICKS packages."
  PACKAGES=$(winetricks list-installed)

  echo -e "  [--] Checking: 'dotnet48' installed."
  DOTNET48=$(echo "$PACKAGES" | grep dotnet48)
  if [ -z "$DOTNET48" ]; then
    echo -e "    [!!] 'dotnet48' is missing, installing."
    winetricks dotnet48
  fi
  echo -e "  [++] Has: 'dotnet48' installed."

  echo -e "  [--] Checking: 'corefonts' installed."
  COREFONTS=$(echo "$PACKAGES" | grep corefonts)
  if [ -z "$COREFONTS" ]; then
    echo -e "    [!!] 'corefonts' is missing, installing."
    winetricks corefonts
  fi
  echo -e "  [++] Has: 'corefonts' installed."
  echo -e "[++] WINETRICKS packages are installed."
}

# Checks to make sure WINE is installed, along with its requirements.
function install_check_uopatcher
{
  echo "[++] Check WINE and WINETRICKS installation."
  if ! command -v perl &> /dev/null; then
    echo "  [!!] Perl is required and not installed."
    exit
  fi

  if ! command -v git &> /dev/null; then
    echo "  [!!] Git is required and not installed."
    exit
  fi

  if ! command -v brew &> /dev/null; then
    echo "  [!!] Brew is required and not installed."
    exit
  fi

  if ! command -v wine &> /dev/null; then
    echo "  [!!] Wine is required and not installed."
    brew install --cask --no-quarantine gcenx/wine/wine-crossover
  fi

  if ! command -v winetricks &> /dev/null; then
    echo "  [!!] Winetricks is required and not installed."
    brew install --formula gcenx/wine/winetricks
  fi
  echo "[++] WINE and WINETRICKS installation good."
}

# Validates WINEs Registry.
function patch_wine_registry
{
  echo "[--] Checking WINE Registry."

  REG_FILE="$WINE_DIR/user.reg"
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

# Step 1: INSTALL, Ensure all files and packages are installed.
install_check_wine
install_check_winetricks

# Step 2: PATCH, Validate and modify settings/configurations and files.
patch_wine_registry

# Step 3: LAUNCH, start the client.
