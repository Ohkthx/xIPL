<p align="center">
    <a href="https://patreon.com/ohkthx" title="Donate to this project using Patreon">
        <img src="https://img.shields.io/badge/patreon-donate-red.svg?style=for-the-badge&color=f38ba8&label=PATREON&logo=patreon&logoColor=f38ba8&labelColor=11111b"
            alt="Patreon donate button"></a>
    <a href="https://ko-fi.com/G2G0J79MY" title="Donate to this project using Ko-fi">
        <img src="https://img.shields.io/badge/kofi-donate-ffffff.svg?style=for-the-badge&color=fab387&label=KOFI&logo=kofi&logoColor=fab387&labelColor=11111b"
            alt="Buy me a coffee! Ko-fi"></a>
<br>
   <a href="https://github.com/ohkthx/uopatcher" title="Required Python Version.">
        <img src="https://img.shields.io/badge/python-3.9.1+-11111b.svg?style=for-the-badge&color=f9e2af&label=PYTHON&logo=python&logoColor=f9e2af&labelColor=11111b"
            alt="Required Python Version."></a>
    <a href="https://github.com/ohkthx/xIPL" title="Size of the repo!">
        <img src="https://img.shields.io/github/repo-size/ohkthx/xIPL?style=for-the-badge&color=cba6f7&label=SIZE&logo=codesandbox&logoColor=cba6f7&labelColor=11111b"
            alt="No data."></a>
<br>
   <a href="https://discord.gg/HP3fGNtzfs" title="Connect to the community!">
        <img src="https://img.shields.io/badge/discord-accept%20invite-11111b.svg?style=for-the-badge&color=89B4FA&label=DISCORD&logo=discord&logoColor=89b4fa&labelColor=11111b"
            alt="Discord connect button."></a>
</p>

# xIPL, Cross-platform (x) Installer, Patcher, and Launcher (IPL)

The **xIPL** is a fancy **bash** script designed to automate the **I**nstallation, **P**atching, and **L**aunching of Ultima Online. This software aims to be compatible with Linux, BSD, and MacOS (Intel-base Processors) along with MacOS (M1/M2 Processors).

<ins>Feel free to join the **Ultima Online: Linux and MacOS** community by clicking **ACCEPT INVITE** button above.</ins>

The original patching concept and basis for this project is accredited to [Voxpire](https://github.com/Voxpire) with his [ServUO/IPL](https://www.servuo.com/archive/all-in-one-installer-patcher-launcher-ipl.1724/) project. Unfortunately, the project is limited to Microsoft Windows, thus not supporting the audience of my project.

## Features
- Cross-platform, tested in Linux (Intel 64-bit) and MacOS (ARM M2)
- Configurable to various shards.
- xIPL auto-updates itself.
- Auto-configures settings.
- Installs / Patches client
- Launches client

#### TODO
- Preserve backup of macro profiles.

## Optional: Configuration and Shard Specific Settings

The default configuration for the **xIPL** is aimed at the shard **Shadow Age: REBORN**. If you would like to have your shard added to the '[shards/](https://github.com/Ohkthx/xIPL/tree/main/shards)' directory, then feel free to contact me at:
| Service | Username    | ID                 |
|:-------:|:-----------:|:------------------:|
| Discord | Schism#6126 | 113426175669313536 |
 
When messaging me, please __**do not forget**__ include your configuration file. An example can be found [here](https://github.com/Ohkthx/xIPL/blob/main/shards/example). After your configuration is added, users will then be able to edit line 12 of **xIPL** with the name of your configuration. I retain the right to edit or remove any configuration for any reason but that is highly unlikely to ever happen. The most likely scenario is in the event a future patch adds functionality to the **xIPL** and all configurations will need to be updated.

Example provided below to assign the '[example](https://github.com/Ohkthx/xIPL/blob/main/shards/example)' configuration as the **xIPL**'s Shard:

File: `xIPL`
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
SHARD_NAME="example"
```
## Known Issues / Testing

### Tested on
| OS | Arch | Wine Version | Winetricks Version |
|----|------|--------------|--------------------|
| macOS | arm64 | wine-7.7 | 20220411-next |
| linux | x86_64 | wine-5.5 | 20210206 |
| linux | x86_64 | wine-8.0 | 20210206 |

### Issues
<ins>**ClassicUO**</ins>
- **ClassicUO.exe**
    1. linux x86_64, Wine version `wine-5.5` has no audio. Wine version `wine-8.0` audio works.
    2. macOS arm64, Wine version `wine-7.7` audio crackles. No fix yet.
- **ClassicUOLauncher.exe**
    1. linux x86_64, Wine version `wine-5.5` will not start Launcher. Wine version `wine-8.0` it works.

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

#### Requirements

- **Perl** - This is used to replace text in some of the registry files for Wine since **sed**'s behaviour is platform dependent.
- **Git** - Used to download and update additional dependencies.
- **Python** - Minimum of Python 3 version __**3.9.1**__
- **Brew** - (MacOS) Used for the installation of WINE and WINETRICKS.
- **curl** or **wget** - Used for auto-updating the xIPL.
- **Wine** - Run the ClassicUO client. Downloaded automatically for MacOS, package provided by [Gcenx/homebrew-wine](https://github.com/Gcenx/homebrew-wine)
- **Winetricks** - Download and install additional required packages for Wine. Downloaded automatically for MacOS, package provided by [Gcenx/homebrew-wine](https://github.com/Gcenx/homebrew-wine)

#### Dependencies

- **uopatcher** - Downloaded automatically and used for **patching** of the client, provided by [Ohkthx/uopatcher](https://github.com/ohkthx/uopatcher).

## Running

To start the **xIPL**, you just need to type the following. In additional to normal execution, provided are **ALTERNATIVE** steps to make the script executable and started with using `./xIPL`. There is also the `--launcher` flag that can be passed to the **xIPL** to start a launcher such as ClassicUOLauncher if it is specified in the servers configuration files. Other advanced functionality can be seen with the `--help` flag.
```bash
# Start with bash.
bash xIPL             # Normal start.
bash xIPL --help      # See advanced features.
bash xIPL --launcher  # Start a launcher instead of a client.

# ALTERNATIVE: Make it executable and be able to run with ./xIPL
chmod +x xIPL       # Only needs to be performed once to mark it executable.

./xIPL              # Normal start.
./xIPL --help       # See advanced features.
./xIPL --launcher   # Start a launcher instead of a client.
```
