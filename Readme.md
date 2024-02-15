# Arch Linux Basic Installation Guide

This repository is used to perform a simplified Arch Linux installation without having to search for packages. 
This should also serve to introduce Arch Linux to other people.

### Table of contents

* ### [The Basics](guide/basic.md)
    * #### [System Update](./guide/basic.md#System-Update)
    * #### [Remove an App](./guide/basic.md#Remove-an-App)
    * #### [Install an App](./guide/basic.md#Install-an-App)
    * #### [Installing fonts](./guide/basic.md#Installing-fonts)
* ### [Setting up AUR](./guide/aur.md)
    * #### [Install yay](./guide/aur.md#Install-yay)
    * #### [Package Compress](./guide/aur.md#Package-Compress)

### Installing Oh-My-Zsh

#### Run the Installer

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Getting the plugins
```shell
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
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

* Th part of the instructions is not necessary and can be ignored. This is only about advanced styling.

#### Adding powerlevel10k
```shell
yay -S --noconfirm zsh-theme-powerlevel10k-git
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
    alias ls="colorls"
    alias la="colorls -al"
fi
```



# Important Fixes

### HiDPI Scaling Fix for Mutter<>
```bash
yay -S mutter-x11-scaling

gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
```

# Service Configuration

### CUPS (Printer) Service & Brother Driver
```bash
sudo systemctl enable cups.service
sudo systemctl enable cups.socket
sudo systemctl start cups.service

yay -S brother-mfc-l2710dw
```

### Bluetooth Service
```bash
modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
```

### OpenSnitch Service
```bash
sudo systemctl enable opensnitchd
sudo systemctl start opensnitchd.service 
```


### Clear Packagemanager cache
```bash
yay -Scc
```

# Software Installation Guide

## Basic System Software (Pacman)
```bash
sudo pacman -S discord bitwarden chromium evolution opensnitch
```

## Dev-Tools

### SDKs (Pacman)
```bash
sudo pacman -S dotnet-sdk mono cmake clang ninja gdb nodejs npm python
```

### SDKs (AUR)
```bash
yay -S --noconfirm jdk-temurin flutter swift-bin
```

### Visual Studio Code
```bash
yay -S --noconfirm visual-studio-code-bin
```

### JetBrains
```bash
yay -S --noconfirm intellij-idea-ultimate-edition rider clion clion-jre pycharm-professional
```

### Android Studio
```bash
yay -S --noconfirm android-studio
```

## Browser

### Chromium
```bash
sudo pacman -S chromium
```
Already installed with "Basic System Software (Pacman)"

### Microsoft Edge
```bash
yay -S --noconfirm microsoft-edge-stable-bin
```
### Ungoogled Chromium
```bash
yay -S --noconfirm ungoogled-chromium-bin
```

### Thorium Browser
```bash
yay -S --noconfirm thorium-browser-bin
```

## Gnome Tweaks

### Gnome Browser Connector
```bash
yay -S --noconfirm gnome-browser-connector
```

# Config Files

### Kitty
```bash
cp -a -f kitty.conf ~/.config/kitty/
```

### Oh-My-Zsh
```bash
cp -a -f .zshrc ~/
```

### Makepkg
```bash
cp -a -f makepkg.conf /etc/
```

# Good to know

### Clear caches
```bash
yay -Scc
```

### Fix nVidia Driver Hibernation
```bash
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
```

### Remove not needed Packages
```bash
yay -Yc
```

### Startpage Search Query
```bash
Startpage.com
:sp
https://www.startpage.com/do/search?q=%s
```


### Gnome Extensions
[Dash-To-Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)\
[Logo-Menu](https://extensions.gnome.org/extension/4451/logo-menu/)\
[Clipboard Manager](https://extensions.gnome.org/extension/779/clipboard-indicator/)\
[Tray Icons](https://extensions.gnome.org/extension/2890/tray-icons-reloaded/)\
[Transparent Top Bar](https://extensions.gnome.org/extension/3960/transparent-top-bar-adjustable-transparency/)\
[App Menu](https://extensions.gnome.org/extension/6433/app-menu-is-back/)\
[Top Hat](https://extensions.gnome.org/extension/5219/tophat/)\
[Blur-My-Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)\
[Custom Accent Colors](https://extensions.gnome.org/extension/5547/custom-accent-colors/)\
[Rounded Corners](https://extensions.gnome.org/extension/1514/rounded-corners/)