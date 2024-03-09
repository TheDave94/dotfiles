#!/bin/sh

echo "Start basic package installation now."
echo "Press enter to continue..."
read
echo "---------------------------------------------------------------"

echo "-------------------------------------------------"
echo "Performing package installation: pacman -S"
echo "-------------------------------------------------"

packages=(
    "git"
    "base-devel"
    "bluez"
    "bluez-utils"
    "cups"
    "cups-pdf"
    "zsh"
    "which"
    "github-cli"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
    "fzf"
    "ufw"
)

for package in "${packages[@]}"; do
    echo "----------------------------------"
    echo "Installing package: $package"
    echo "----------------------------------"
    sudo pacman -S --needed ${package}
done

echo "---------------------------------------------------------------"

echo "-------------------------------------------------"
echo "Installing oh-my-zsh"
echo "-------------------------------------------------"

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh
sed -i.tmp 's:env zsh::g' install.sh
sed -i.tmp 's:chsh -s .*$::g' install.sh
sh install.sh

echo "-------------------------------------------------"
echo "Adding plugins"
echo "-------------------------------------------------"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

