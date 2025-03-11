#!/bin/sh

echo "--- Updating System ---"

sudo pacman -Syuu --noconfirm

# https://unix.stackexchange.com/questions/691386/remove-preinstalled-gnome-applications
sudo pacman -Rncs --noconfirm vim gnome-music totem yelp gnome-contacts gnome-clocks gnome-maps gnome-weather epiphany malcontent gnome-tour
sudo pacman -S --needed --noconfirm flatpak libportal-gtk3

echo "--- Installing AUR-Helper ---"

sudo pacman -S --needed --noconfirm base-devel

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
cd ../ && rm -rf yay

echo "--- Installing Software ---"

pkgs=(
  "git"
  "bluez"
  "bluez-utils"
  "cups"
  "cups-pdf"
  "zsh"
  "which"
  "github-cli"
  "fzf"
  "ufw"
  "zoxide"
  "exa"
  "unrar"
  "unzip"
  "zip"
  "p7zip"
  "libheif"
  "ntfs-3g"
  "fastfetch"
  "zlib"
  "zenity"
  "zxing-cpp"
  "xvidcore"
  "wget"
  "whois"
  "usbutils"
  "aspell"
  "aspell-de"
  "earlyoom"
  "rsync"
  "reflector"
  "bat"
  "fd"
  "starship"
  "xclip"
  "tree"
  "ripgrep"
  "tmux"
# ----------- #  
  "bitwarden"
  "vlc"
  "gufw"
  "linux-firmware-qlogic"
  "spotify-launcher"
  "ghostty"
  "gimp"
  "lazygit"
  "system-config-printer"
# ---------- # 
# Add some themes here
# ---------- # 
  "cmake"
  "clang"
  "ninja"
  "gdb"
  "go"
  "python"
  "nodejs"
  "npm"
  "kotlin"
# ---------- # 
  "ttf-meslo-nerd"
  "powerline-fonts"
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-extra"
  "noto-fonts-emoji"
)

for pkg in "${pkgs[@]}"; do
  echo "-- Installing: $pkg"
  sudo pacman -S --needed --noconfirm ${pkg}
done

echo "--- Installing AUR Software ---"

aurpkgs=(
  "brother-mfc-l2710dw"
  "zoom"
  "aic94xx-firmware"
  "wd719x-firmware"
  "upd72020x-fw"
  "ast-firmware"
  "visual-studio-code-bin"
  "rustdesk-bin"
  "brave-bin"
  "megasync-bin"
  "ttf-maple"
  "ttf-ms-win11-auto"
  "jdk-temurin"
  "vmware-workstation"
  "kanata-bin"
)

echo "--- Enabling Services ---"

sudo systemctl enable cups.service
sudo systemctl enable cups.socket
sudo systemctl start cups.service

sudo systemctl enable vmware-networks.service
sudo systemctl start vmware-networks.service
sudo systemctl enable vmware-usbarbitrator
sudo systemctl start vmware-usbarbitrator

modprobe btusb
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

echo "--- Configuring Firewall ---"

sudo ufw default reject
sudo ufw enable
sudo systemctl enable ufw.service

echo "--- Configuring Zsh ---"

chsh -s $(which zsh)
ln -sf $PWD/config/.zshrc ~/

echo "--- Configuring Kitty ---"

mkdir -p ~/.config/kitty/
ln -sf $PWD/config/kitty/kitty.conf ~/.config/kitty/
ln -sf $PWD/config/kitty/current-theme.conf ~/.config/kitty/

# echo "--- Installing Language Servers ---"

# sudo pacman -S --needed --noconfirm pyright go

# go install golang.org/x/tools/gopls@latest
# go install github.com/go-delve/delve/cmd/dlv@latest
# go install golang.org/x/tools/cmd/goimports@latest
# go install github.com/nametake/golangci-lint-langserver@latest
# go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

echo "--- Tmux ---"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf $PWD/config/tmux/.tmux.conf ~/

echo "--- Configuring Starship ---"

ln -sf $PWD/config/starship.toml ~/.config/

echo "--- Configuring Nvidia ---"

sudo pacman -S --needed --noconfirm libva-nvidia-driver

sudo systemctl daemon-reload
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
sudo systemctl daemon-reload

sudo cp -r $PWD/config/nvidia/nvidia.conf /etc/modprobe.d/
sudo cp -r $PWD/config/nvidia/nvidia_drm.conf /etc/modprobe.d/
sudo ln -sf $PWD/config/nvidia/environment /etc/

echo "--- Configuring Kanata ---"

sudo cp -r $PWD/config/kanata/kanata.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable kanata.service
sudo systemctl start kanata.service
sudo systemctl daemon-reload

mkdir -p ~/.config/kanata
ln -sf $PWD/config/kanata/main.kbd ~/.config/kanata/

echo "--- Cleaning Up ---"

yay -Scc --noconfirm
yay -Yc --noconfirm

sudo mkinitcpio -P

echo "--- Rebooting ---"

echo "-- Installation Finished"
echo "-- Press enter to continue --"
read

reboot
