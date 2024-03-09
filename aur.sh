#!/bin/sh

echo "Installing yay"
echo "Press enter to continue..."
read
echo "---------------------------------------------------------------"

cd $PWD/files/
git clone https://aur.archlinux.org/yay.git && cd yay
makepkg -si
cd ../
rm -rf yay
cd ../

echo "----------------------------------"
echo "Change file makepkg.conf"
echo "----------------------------------"

sudo ln -sf $PWD/files/makepkg.conf /etc/