{ "version": [0, 0, 1] }

# xipl, Cross-platform (x) Installer, Patcher, and Launcher (ipl)

The **xipl** is a fancy **bash** script designed to automate the **i**nstallation, **p**atching, and **l**aunching of Ultima Online. Targeted at the shard Shadow Age: REBORN, this software aims to be compatible with Linux, BSD, and MacOS (Intel-base Processors) along with MacOS (M1/M2 Processors).

## TODO
- Create a notification system for new **xipl** updates.

### Requirements

- **Perl** - This is used to replace text in some of the registry files for Wine since **sed**'s behaviour is platform dependent.
- **Git** - Used to download and update additional dependencies.
- **Python** - Minimum of Python 3 version __**3.9.1**__
- **Brew** - (MacOS) Used for the installation of WINE and WINETRICKS.
- **Wine** - Run the ClassicUO client. Downloaded automatically for MacOS, package provided by [Gcenx/homebrew-wine](https://github.com/Gcenx/homebrew-wine)
- **Winetricks** - Download and install additional required packages for Wine. Downloaded automatically for MacOS, package provided by [Gcenx/homebrew-wine](https://github.com/Gcenx/homebrew-wine)

### Dependencies

- **uopatcher** - Downloaded automatically and used for **patching** of the client, provided by [Ohkthx/uopatcher](https://github.com/ohkthx/uopatcher).

### Installation

It is ideal to store the installation script in its own directory, below provides commands to create that directory in the terminal and switch to it. The method to downloading the client is up to you. You can use **curl**, **wget**, or just copy the raw file from the browser. **curl** and **wget** commands are provided below.

```bash
# Create a directory and enter it for the installation.
mkdir xipl
cd xipl

# Obtaining the xipl with CURL
curl -O https://raw.githubusercontent.com/Ohkthx/xipl/main/xipl.sh

# Obtaining the xipl with WGET
wget https://raw.githubusercontent.com/Ohkthx/xipl/main/xipl.sh

```

### Running

To start the **xipl**, you just need to type the following. In additional to normal execution, provided are **OPTIONAL** steps to make the script executable and started with using `./xipl.sh`
```bash
# Start with bash.
bash xipl.sh

# OPTIONAL: Make it executable and be able to run with ./xipl.sh
chmod +x xipl.sh
./xipl.sh
```
