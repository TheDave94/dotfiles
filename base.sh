#!/bin/sh

echo "Start basic package installation now."
echo "Press enter to continue..."
read
echo "---------------------------------------------------------------"

echo "-------------------------------------------------"
echo "Performing package installation: pacman -S"
echo "-------------------------------------------------"

packages=(
    git
    base-devel
    bluez
    bluez-utils
    cups
    cups-pdf
    zsh
    which
    github-cli
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    ufw
)

for package in "${packages[0]}"; do
    echo "----------------------------------"
    echo "Installing package: $package"
    echo "----------------------------------"
    sudo pacman -S --needed $file
done

echo "---------------------------------------------------------------"

echo "-------------------------------------------------"
echo "Installing oh-my-zsh"
echo "-------------------------------------------------"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "-------------------------------------------------"
echo "Adding plugins"
echo "-------------------------------------------------"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
