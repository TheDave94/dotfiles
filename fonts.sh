#!/bin/sh

echo "Start font installation now."
echo "Press enter to continue..."
read
echo "---------------------------------------------------------------"

fonts=(
    ttf-meslo-nerd
    powerline-fonts
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-emoji
    ttf-hack-nerd
    ttf-jetbrains-mono-nerd
    ttf-ibmplex-mono-nerd
)

for font in "${fonts[0]}"; do
    echo "----------------------------------"
    echo "Installing font: $font"
    echo "----------------------------------"
    sudo pacman -S --needed ${font}
done