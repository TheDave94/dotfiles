### Basic Installation Guide with Cinnamon
---
#### System Update

```shell
sudo pacman -Syu
```
* To install or update packages from the official Arch repository, or to perform a system update us pacman.

```shell
yay
```

* To install or update packages from the user repository (AUR), use yay. 

---

#### Install an App
```shell
sudo pacman -S git base-devel bluez bluez-utils cups cups-pdf zsh which flatpak xdg-desktop-portal xdg-desktop-portal-xapp xdg-desktop-portal-gtk gnome-software
```

* Adding `-S` is necessary for an installation.
<br>

* git is self-explanatory.
* bluez and bluez-utils is needed for Bluetooth.
* cups is the printer server. It is needed to install a printer.
* cups-pdf is needed if you want to Print-To-PDF.
* zsh is a unix-shell. (Needed if you want to use Oh-My-Zsh later).
* which is used to identify a location of a given executable.
* flatpak is used to install software from flathub
    * xdg-desktop-portal and xdg-desktop-portal-xyz is needed to have access to other system apps (like the Browser)
    * gnome-software is a store gui for flatpak

<br>

```shell
yay -S yourApp
```

* Using `yay -S` is necessary to install apps from the AUR.

---

#### Remove an App

```shell
sudo pacman -Rcns yourApp
```

```shell
yay -Rcns yourApp
```

* Adding `-R` will remove the package.
* Adding `-Rcns` will remove the package, each dependency (if no longer required) and configuration files.

---

### Arch AUR Setup

### Install yay
```shell
git clone https://aur.archlinux.org/yay.git && cd yay

makepkg -si
```

### Package compress
```shell
sudo nano /etc/makepkg.conf
```
* Add `PKGEXT='.pkg.tar'` to "EXTENSION DEFAULTS"

The following skips compression of the package file, which will in turn have no need to be decompressed. It speeds up the installation progress.

---

### Installing Oh-My-Zsh

#### Run the Installer

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

#### Getting the plugins

```shell
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting
```

```shell
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

```shell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

```shell
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
```

```shell
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
```

#### Adding the plugins to .zshrc
```shell
nano ~/.zshrc
```

```shell
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

# Plugin Setup
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a8a8a8"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC="1"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"
```

---

#### Adding powerlevel10k
```shell
yay -S --noconfirm zsh-theme-powerlevel10k-git
```

```shell
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

#### Styling ls & la
```shell
yay -S --noconfirm ruby-colorls
```

#### Adding ruby-colorls to .zshrc
```shell
nano ~/.zshrc
```

```shell
# Colorls
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls -al"
    alias la="colorls"
fi
```

### Configuration Guide

---

#### CUPS (Printer) Service & Brother Driver

```shell
sudo systemctl enable cups.service
```

```shell
sudo systemctl enable cups.socket
```

```shell
sudo systemctl start cups.service
```
<br>

**This step is optional as you may not have the same Brother (printer) model.**

<br>

```shell
yay -S brother-mfc-l2710dw
```
---

#### Bluetooth Service

```shell
modprobe btusb
```

```shell
sudo systemctl enable bluetooth.service
```

```shell
sudo systemctl start bluetooth.service
```
---
<br>

**This step is optional as you may not have installed OpenSnitch.**

#### OpenSnitch Service

```shell
sudo systemctl enable opensnitchd
```

```shell
sudo systemctl start opensnitchd.service 
```
---
<br>

**This step is optional as you may not have an nVidia GPU.**

#### nVidia Patches

```shell
sudo systemctl enable nvidia-suspend.service
```

```shell
sudo systemctl enable nvidia-hibernate.service
```

```shell
sudo systemctl enable nvidia-resume.service
```

```shell
sudo touch /etc/modprobe.d/nvidia.conf && sudo nano /etc/modprobe.d/nvidia.conf
```

```shell
options nvidia NVreg_PreserveVideoMemoryAllocations=1
```
<br>

* As per Kernel module#Using files in /etc/modprobe.d/, you will need to regenerate the initramfs if using early KMS.

```shell
sudo mkinitcpio -P
```

### Software Installation

---
#### Applications & SDKs (Pacman)

```shell
sudo pacman -S ...
```

**Software**
* `discord` 
* `bitwarden`
* `chromium`
* `flameshot`
* `gnome-screenshot`
* `lightdm-gtk-greeter-settings` - **Only needed if you use lightdm-greeter**
* `opensnitch`
* `plan` - **Only needed if you want to have a dock**
---
**SDK & Devtools**
* `dotnet-sdk` 
* `mono`
* `cmake`
* `clang`
* `ninja`
* `gdb`
* `nodejs`
* `npm`
* `python`

---
#### Applications & SDKs (AUR)

```shell
yay -S ...
```

**IDEs**
* `visual-studio-code-bin` 
* `intellij-idea-ultimate-edition`
* `rider`
* `clion`
* `clion-jre` - **clion will not start without it!**
* `pycharm-professional`
* `android-studio`
---
**SDK & Devtools**
* `jdk-temurin` 
* `flutter`
* `swift-bin`
---
**Browser**
* `microsoft-edge-stable-bin` 
* `ungoogled-chromium-bin`
* `thorium-browser-bin`
* `brave-bin`
---
#### Themes (AUR)

```shell
yay -S ...
```

**Themes**
* `whitesur-gtk-theme` 
* `colloid-gtk-theme-git`
* `plank-theme-arian-git`
---
**Icons**
* `whitesur-icon-theme`
---
**Cursor**
* `whitesur-gtk-theme` 
* `whitesur-cursor-theme-git`

### Good to know

---
#### Startpage Settings for Chromium

```shell
Startpage.com
:sp
https://www.startpage.com/do/search?q=%s
```
---
#### Remove unnecessary packages

```shell
yay -Yc
```
---
#### Clear pacman and yay cache

```shell
yay -Scc
```
---
#### Config Files

**Kitty**
```shell
cp -a -f kitty.conf ~/.config/kitty/
```
---
***Oh-My-Zsh**
```shell
cp -a -f .zshrc ~/
```
---
**Makepkg**
```shell
cp -a -f makepkg.conf /etc/
```
---
**nVidia**
```shell
cp -a -f nvidia.conf /etc/modprobe.d/
```