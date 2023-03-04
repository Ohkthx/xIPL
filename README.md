<p align="center">
    <a href="https://patreon.com/ohkthx" title="Donate to this project using Patreon">
        <img src="https://img.shields.io/badge/patreon-donate-red.svg?style=for-the-badge&logo=patreon"
            alt="Patreon donate button"></a>
    <a href="https://ko-fi.com/G2G0J79MY" title="Donate to this project using Ko-fi">
        <img src="https://img.shields.io/badge/kofi-donate-ffffff.svg?style=for-the-badge&logo=kofi"
            alt="Buy me a coffee! Ko-fi"></a>
</p>

# xIPL, Cross-platform (x) Installer, Patcher, and Launcher (IPL)

The **xIPL** is a fancy **bash** script designed to automate the **I**nstallation, **P**atching, and **L**aunching of Ultima Online. This software aims to be compatible with Linux, BSD, and MacOS (Intel-base Processors) along with MacOS (M1/M2 Processors).

## Features
- Cross-platform, tested in Linux (Intel 64-bit) and MacOS (ARM M2)
- Configurable to various shards.
- xIPL auto-updates itself.
- Auto-configures settings.
- Installs / Patches client
- Launches client

## TODO
- Optimize WINETRICKS package checking or...
- **-skip** command for Winetricks.
- Preserve backup of macro profiles.
- Persistent settings between patches: ClassicUO/settings.json

## Optional: Configuration

The default configuration for the **xIPL** is aimed at the shard Shadow Age: REBORN. If you would like to have your shard added to the '[shards/](https://github.com/Ohkthx/xIPL/tree/main/shards)' directory, then feel free to message me on discord @Schism#6126 (id: 113426175669313536). Users will then be able to edit line 12 of **xIPL**. Example provided below to assign 'shadowage_reborn' as the shard to use:

`xIPL`
```bash
#!/usr/bin/env bash

# Created by: Ohkthx (Schism)
# Purpose of file: This is a wrapper for all functions inside of
#   xIPL_extras, that is responsible for keeping that file updated
#   with the current release available.
#   If a new update is available, this script downloads and launches it.

# Name of the shard to patch for, check out:
#   https://github.com/Ohkthx/xIPL/tree/main/shards
# For all valid shard names.
SHARD_NAME="shadowage_reborn"
```

## Requirements

- **Perl** - This is used to replace text in some of the registry files for Wine since **sed**'s behaviour is platform dependent.
- **Git** - Used to download and update additional dependencies.
- **Python** - Minimum of Python 3 version __**3.9.1**__
- **Brew** - (MacOS) Used for the installation of WINE and WINETRICKS.
- **curl** or **wget** - Used for auto-updating the xIPL.
- **Wine** - Run the ClassicUO client. Downloaded automatically for MacOS, package provided by [Gcenx/homebrew-wine](https://github.com/Gcenx/homebrew-wine)
- **Winetricks** - Download and install additional required packages for Wine. Downloaded automatically for MacOS, package provided by [Gcenx/homebrew-wine](https://github.com/Gcenx/homebrew-wine)

## Dependencies

- **uopatcher** - Downloaded automatically and used for **patching** of the client, provided by [Ohkthx/uopatcher](https://github.com/ohkthx/uopatcher).

## Installation

It is ideal to store the installation script in its own directory, below provides commands to create that directory in the terminal and switch to it. The method to downloading the client is up to you. You can use **curl**, **wget**, or just copy the raw file from the browser. **curl** and **wget** commands are provided below.

```bash
# Create a directory and enter it for the installation.
mkdir xIPL
cd xIPL

# Obtaining the xIPL with CURL
curl -O https://raw.githubusercontent.com/Ohkthx/xIPL/main/xIPL

# Obtaining the xIPL with WGET
wget https://raw.githubusercontent.com/Ohkthx/xIPL/main/xIPL

```

### Running

To start the **xIPL**, you just need to type the following. In additional to normal execution, provided are **OPTIONAL** steps to make the script executable and started with using `./xIPL`
```bash
# Start with bash.
bash xIPL

# OPTIONAL: Make it executable and be able to run with ./xIPL
chmod +x xIPL
./xIPL
```
