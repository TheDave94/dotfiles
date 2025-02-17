#!/bin/sh

echo "--- Updating System ---"

sudo pacman -Syuu --noconfirm

sudo pacman -Rncs --noconfirm vim kate

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
  "kitty"
  "spectacle"
  "partitionmanager"
  "okular"
  "kvantum"
  "gimp"
  "lazygit"
  "system-config-printer"
  "intellij-idea-community-edition"
  "solaar"
# ---------- # 
  "materia-kde"
  "kvantum-theme-materia"
  "materia-gtk-theme"
  "gtk-engine-murrine"
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
  "anydesk-bin"
  "rustdesk-bin"
  "brave-beta-bin"
  "ungoogled-chromium-bin"
  "megasync-bin"
  "ttf-maple"
  "ttf-ms-win11-auto"
  "jdk-temurin"
  "vmware-workstation"
)

for pkg in ${aurpkgs[@]}; do
  echo "-- Installing: $pkg"
  yay -S --noconfirm ${pkg}
done

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

echo "--- Installing Language Servers ---"

sudo pacman -S --needed --noconfirm pyright go

go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

echo "--- Installing Themes ---"

git clone https://github.com/vinceliuice/WhiteSur-cursors.git
cd WhiteSur-cursors
./install.sh 
cd ..
rm -rf WhiteSur-cursors

git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git
cd Tela-circle-icon-theme
./install.sh manjaro
cd ..
rm -rf Tela-circle-icon-theme

echo "--- Tmux ---"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf $PWD/config/tmux/.tmux.conf ~/

echo "--- Configuring Starship ---"

ln -sf $PWD/config/starship.toml ~/.config/

echo "--- Configuring Nvidia ---"

sudo pacman -S --needed --noconfirm libva-nvidia-driver

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

sudo ln -sf $PWD/config/nvidia/nvidia.conf /etc/modprobe.d/
sudo ln -sf $PWD/config/nvidia/nvidia_drm.conf /etc/modprobe.d/
sudo ln -sf $PWD/config/nvidia/environment /etc/

echo "--- Cleaning Up ---"

yay -Scc --noconfirm
yay -Yc --noconfirm

sudo mkinitcpio -P

echo "--- Rebooting ---"

echo "-- Install Plasma Drawer and Wallpaper Effects from the Store --"

echo "-- Installation Finished"
echo "-- Press enter to continue --"
read

reboot
