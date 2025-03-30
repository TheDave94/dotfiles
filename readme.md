# f0xfiles

> [!WARNING]  
> Ongoing rework of the installation script.
> v 2.0 will be out soon.

This repository contains my dotfiles. Feel free to contribute or use that as a template for your own dotfiles.

## Usage

Before you start the installation, make sure to adjust the software you want or need. Mine is maybe different to yours. 

* On Arch Linux:

```bash
$ cd ~/.config
$ git clone https://github.com/f0xb17/dotfiles.git
$ cd dotfiles
$ chmod 755 install.sh
$ ./install.sh
```

* On Windows:

```powershell
$ git -b windows clone https://github.com/f0xb17/dotfiles.git
$ cd dotfiles
$ Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
$ ./install.ps1
```

## Good to know

* ``[System.Environment]::SetEnvironmentVariable('SCOOP', 'D:\Scoop', 'User')``: Install Scoop Packages to a different location


## Requirements
* [Maple Mono (Nerd) Font](https://github.com/subframe7536/Maple-font): Which is used in most of my configs. Will be installed through AUR.
* [Kitty](https://sw.kovidgoyal.net/kitty/): Which is my Terminal Emulator of choice. Will be installed with Pacman.

