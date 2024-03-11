#!/bin/sh

echo "Creating symlinks now."
echo "---------------------------------------------------------------"

echo "----------------------------------"
echo "Configure zsh"
echo "----------------------------------"

ln -sf $PWD/files/.zshrc $HOME/
ln -sf $PWD/files/.aliases $HOME/

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
echo "Downloading Tilix themes"
echo "----------------------------------"

cd $PWD/files/
git clone https://github.com/MichaelThessel/tilix-gruvbox.git
cd $PWD/tilix-gruvbox
sudo cp -r gruvbox-dark-hard.json gruvbox-dark-medium.json gruvbox-dark-soft.json gruvbox-dark.json /usr/share/tilix/schemes/
cd ../
rm -rf tilix-gruvbox

echo "----------------------------------"
echo "Downloading themes"
echo "----------------------------------"

git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git
cd $PWD/Gruvbox-GTK-Theme/themes/
sudo cp -r Gruvbox-Dark-B-LB Gruvbox-Dark-B Gruvbox-Dark-BL-LB Gruvbox-Dark-BL /usr/share/themes/
cd  ../../
rm -rf Gruvbox-GTK-Theme

echo "----------------------------------"
echo "Write Chromium Settings"
echo "----------------------------------"

cp -r $PWD/Preferences $HOME/.config/chromium/Default

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

echo "----------------------------------"
echo "Change shell from bash to zsh"
echo "----------------------------------"

chsh -s $(which zsh)

echo "----------------------------------"
echo "Set new permissions for VS-Code folder."
echo "----------------------------------"

sudo chown -R $(whoami) /opt/visual-studio-code

echo "----------------------------------"
echo "Set new permissions for Virtualbox"
echo "----------------------------------"

sudo usermod -a -G vboxusers $(whoami)

echo "----------------------------------"
echo "Cleaning"
echo "----------------------------------"

yay -Scc
yay -Yc

sudo mkinitcpio -P

echo "----------------------------------"
echo "Finishing"
echo "----------------------------------"

if [ $XDG_CURRENT_DESKTOP = "GNOME" ]; then 
    sudo pacman -Rcns gnome-music totem yelp gnome-contacts gnome-clocks gnome-maps gnome-weather vim
fi
