# Basic system component installation

### Systemupdate
```bash
sudo pacman -Syu
```

### Delete standard GNOME apps
```bash
sudo pacman -Rns totem gnome-weather gnome-contacts gnome-clocks gnome-maps gnome-music
```

### Installing the basic components
```bash
sudo pacman -S git ttf-meslo-nerd powerline-fonts base-devel nodejs npm python bluez bluez-utils cups cups-pdf zsh which
```

### Installing oh-my-zsh and plugins
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

sudo cp $PWD/.zshrc $HOME/.zshrc
```

# Setup Arch AUR

### Install yay
```bash
git clone https://aur.archlinux.org/yay.git && cd yay

makepkg -si
```