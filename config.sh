#!/bin/sh

echo "Creating symlinks now."
echo "---------------------------------------------------------------"

echo "----------------------------------"
echo "Configure zsh"
echo "----------------------------------"

ln -sf $PWD/files/.zshrc $HOME/
ln -sf $PWD/files/.aliases $HOME/

echo "----------------------------------"
echo "Change file makepkg.conf"
echo "----------------------------------"

sudo ln -sf $PWD/files/makepkg.conf /etc/

echo "----------------------------------"
echo "Creating folder /etc/cmdline.d/"
echo "----------------------------------"

sudo mkdir /etc/cmdline.d/
sudo ln -sf $PWD/files/root.conf /etc/cmdline.d/

echo "----------------------------------"
echo "Adding files to /etc/modprobe.d/"
echo "----------------------------------"

sudo ln -sf $PWD/files/nvidia.conf /etc/modprobe.d/

echo "----------------------------------"
echo "Adding tilix themes"
echo "----------------------------------"

cd $PWD/files/
git clone https://github.com/MichaelThessel/tilix-gruvbox.git
cd tilix-gruvbox
sudo cp -r gruvbox-dark-hard.json gruvbox-dark-medium.json gruvbox-dark-soft.json gruvbox-dark.json /usr/share/schemes/
cd ../
rm -rf tilix-gruvbox

sudo mkinitcpio -P

echo "----------------------------------"
echo "Activate CUPS Service"
echo "----------------------------------"

sudo systemctl enable cups.service
sudo systemctl enable cups.socket
sudo systemctl start cups.service

echo "----------------------------------"
echo "Activate Bluetooth Service"
echo "----------------------------------"

modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

echo "----------------------------------"
echo "Activate Firewall Service"
echo "----------------------------------"

sudo ufw default reject
sudo ufw enable
sudo systemctl enable ufw.service

echo "----------------------------------"
echo "Activate nvidia Service"
echo "----------------------------------"

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service