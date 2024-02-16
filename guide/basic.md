### Basic Installation Guide

#### System Update

```shell
sudo pacman -Syu
```

Later you can also use yay to run updates. However, I would recommend carrying out both one after the other. 

```shell
yay
```

#### Remove an App

```shell
sudo pacman -Rscn totem gnome-weather gnome-contacts gnome-clocks gnome-maps gnome-music
```

* Adding `-R` will remove the package.
* Adding `-Rcns` will remove the package, each dependency (if no longer required) and configuration files.

The example above removes unneeded Gnome apps, as I would not use them anyway. 

#### Install an App
```shell
sudo pacman -S git base-devel bluez bluez-utils cups cups-pdf zsh which
```

The example above installs important apps. 

* git is self-explanatory.
* bluez and bluez-utils is needed for Bluetooth.
* cups is the printer server. It is needed to install a printer.
* cups-pdf is needed if you want to Print-To-PDF.
* zsh is a unix-shell. (Needed if you want to use Oh-My-Zsh later).
* which is used to identify a location of a given executable.

#### Installing fonts
```shell
sudo pacman -S ttf-meslo-nerd powerline-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji ttf-hack-nerd ttf-ms-win11-auto
```

This command installs all required fonts. You can certainly remove one or the other, and you can also install others, but these have proven themselves so far.

```shell
yay -S sf-fonts
```

This command installs the Apple macOS Systemfont