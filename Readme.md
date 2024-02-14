# Base

### Systemupdate

Update with pacman first.

```bash
sudo pacman -Syu
```

Later you can update with yay (or at least for the AUR Packages.)

```bash
yay
```


### Delete standard GNOME apps

```bash
sudo pacman -Rns totem gnome-weather gnome-contacts gnome-clocks gnome-maps gnome-music
```


### Installing needed Software
```bash
sudo pacman -S git base-devel bluez bluez-utils cups cups-pdf zsh which
```

### Installing fonts
```bash
sudo pacman -S ttf-meslo-nerd powerline-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji ttf-hack-nerd
```

### Installing oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Installing plugins
```bash
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting
```

### Installing plugins pt. 2
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
```

### Terminal styling
```bash
yay -S --noconfirm zsh-theme-powerlevel10k-git ruby-colorls
```

# Setup Arch AUR

### Install yay
```bash
git clone https://aur.archlinux.org/yay.git && cd yay

makepkg -si
```

### Package compress
```bash
sudo nano /etc/makepkg.conf

PKGEXT='.pkg.tar'
```

xf86-input-mtrack-git

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
yay -S jdk-temurin flutter swift-bin
```

### Visual Studio Code
```bash
yay -S visual-studio-code-bin
```

### JetBrains
```bash
yay -S intellij-idea-ultimate-edition rider clion clion-jre pycharm-professional
```

### Android Studio
```bash
yay -S android-studio
```

## Browser

### Chromium
```bash
sudo pacman -S chromium
```
Already installed with "Basic System Software (Pacman)"

### Microsoft Edge
```bash
yay -S microsoft-edge-stable-bin
```
### Ungoogled Chromium
```bash
yay -S ungoogled-chromium-bin
```

### Thorium Browser
```bash
yay -S thorium-browser-bin
```

## Gnome Tweaks

### Gnome Browser Connector
```bash
yay -S gnome-browser-connector
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