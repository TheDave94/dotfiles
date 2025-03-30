#!/bin/bash

# -----------------------------------------------#
#               Config Section                   # 
# -----------------------------------------------#

enable_aur=2
flatpak=1
tmux=0
ghostty=1
kitty=0
gaming=0

# -----------------------------------------------#
#                      Debug                     #
#         You may want to let it as it is!       #
# -----------------------------------------------#

# You may want to change this, when you installed
# your system, but forgot to install gaming.
# You can skip initial set up and jump to gaming

debug_skip=1

# -----------------------------------------------#
#                     Design                     #
#         You may want to let it as it is!       #
# -----------------------------------------------#

function warning() {
    message=$1
    echo -e "\033[33m   -- "$1"\033[0m"
}

function error() {
    message=$1
    echo -e "\033[31m   !! ERROR: "$1"\033[0m"
}

function message() {
    message=$1
    echo -e "\033[32m-- "$1"\033[0m"
}

function drawLine() {
    printf '\e[35m%.0s=\e[0m' {1..80}
    echo
}

draw_section() {
    local title="$1"
    local color_code=33
    local line_length=$(tput cols)

    local padding=$(( (line_length - ${#title} - 2) / 2 ))
    local line
    printf -v line '%*s' "$padding" ''
    line=${line// /=}

    local total_length=$(( ${#line} + ${#title} + ${#line} + 1 ))
    if (( total_length < line_length )); then
        echo -e "\e[${color_code}m${line} ${title^^} ${line}\e[0m"
    else
        echo -e "\e[${color_code}m${title^^}\e[0m"
    fi
}

section_end() {
    local line_length=$(tput cols)
    printf '\e[90m%.0s-\e[0m' $(seq 1 "$line_length")
    echo
}

drawLine() {
    local line_length=$(tput cols)
    printf '\e[35m%.0s=\e[0m' $(seq 1 "$line_length")
    echo
}

# -----------------------------------------------#
#                    Methods                     #
#         You may want to let it as it is!       #
# -----------------------------------------------#

function installPackages() {
    filePath=$1
    command=$2

    if [ ! -s "$filePath" ]; then
        echo "Error: The file $filePath is empty. Please add at least one App to install."
        exit 1
    fi

    while IFS= read -r app_id || [ -n "$app_id" ]; do
        message "Installing: $app_id"
        if [ -n "$app_id" ]; then
            if ! $command "$app_id"; then
                error "Installing App $app_id"
            else
                if [[ $command == *"flatpak"* ]]; then
                    warning "Activate Socket Wayland: $app_id"
                    flatpak override --user --socket=wayland "$app_id"
                    warning "Deactivate Socket X11: $app_id"
                    flatpak override --user --nosocket=x11 "$app_id"
                fi
            fi
        fi
        drawLine
    done < "$filePath"
}

function copyFilesAsAdmin() {
    command=$1
    target=$2
    destination=$3

    sudo $command "$PWD/$target" "$destination"
}

function copyFiles() {
    command=$1
    target=$2
    destination=$3

    $command "$PWD/$target" "$destination"
}

function enableService() {
    serviceName=$1

    sudo systemctl enable "$serviceName"
}

function startService() {
    serviceName=$1

    sudo systemctl start "$serviceName"
}

# -----------------------------------------------#
#                   The Fun Part!                #
#         You may want to let it as it is!       #
# -----------------------------------------------#

cat << "EOF"

███████╗ ██████╗ ██╗  ██╗███████╗██╗██╗     ███████╗███████╗
██╔════╝██╔═══██╗╚██╗██╔╝██╔════╝██║██║     ██╔════╝██╔════╝
█████╗  ██║   ██║ ╚███╔╝ █████╗  ██║██║     █████╗  ███████╗
██╔══╝  ██║   ██║ ██╔██╗ ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██║     ╚██████╔╝██╔╝ ██╗██║     ██║███████╗███████╗███████║
╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
                                                            
EOF

message "Welcome to FoxFiles."

draw_section "Update Services"
    sudo pacman -Syyu --noconfirm
section_end

if [[ $debug_skip == 0 ]]; then
    DESKTOP_ENV=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')
    if [[ "$DESKTOP_ENV" == *"gnome"* ]]; then
        draw_section "Gnome: Fractional Scaling"
            gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'xwayland-native-scaling']"
            warning "Gnome: Fractional Scaling Enabled"
        section_end
        draw_section "Gnome: Removing Apps"
            for app in vim gnome-music totem yelp gnome-contacts gnome-clocks gnome-maps gnome-weather epiphany malcontent gnome-tour htop; do
                sudo pacman -Rncs --noconfirm "$app"
                warning "Removed App: $app"
            done
            for app in flatpak libportal-gtk3; do
                sudo pacman -S --needed --noconfirm "$app"
                warning "Reinstalling App: $app"
            done
        section_end
    elif [[ "$DESKTOP_ENV" == *"kde"* || "$DESKTOP_ENV" == *"plasma"* ]]; then
        draw_section "KDE: Installing Apps"
            for app in spectacle partitionmanager okular; do
                sudo pacman -S --needed --noconfirm "$app"
                warning "Installed App: $app"
            done
        section_end
    fi

    if [[ $flatpak == 1 ]]; then
        if ! type flatpak &> /dev/null; then
            sudo pacman -Sy --needed --noconfirm flatpak
        fi
        draw_section "Installing Flatpaks"
            installPackages "flatpak.txt" "flatpak install -y flathub"
        section_end
    fi

    if type pacman &> /dev/null; then
        draw_section "Installing Basic Packages"
        installPackages "pacman.txt" "sudo pacman -Sy --needed --noconfirm"
        if [[ $enable_aur == 1 ]]; then
            draw_section "Installing PARU"
                git clone https://aur.archlinux.org/paru.git
                cd paru
                makepkg -si
                cd .. && rm -rf paru
                if type paru &> /dev/null; then
                    warning "Paru installed successfully!"
                fi
            section_end
            draw_section "Installing AUR Packages"
                installPackages "aur.txt" "paru -S --needed --noconfirm"
            section_end 
        fi
        if [[ $enable_aur == 0 ]]; then
            draw_section "Installing Firmware"
            error "At this point, you will have to enter your password several times."
            error "Press enter to continue..."
            read
            for pkg in aic94xx-firmware wd719x-firmware ast-firmware; do
                git clone "https://aur.archlinux.org/$pkg.git"
                cd "$pkg" || exit
                makepkg -si
                cd .. && rm -rf "$pkg"
                drawLine
            done
            section_end
        fi
    fi

    if lspci | grep -i nvidia &> /dev/null || lsmod | grep -i nvidia &> /dev/null; then
        draw_section "Nvidia Setup"
            if [ ! -e "/etc/modprobe.d/nvidia_drm.conf" ]; then
                sudo touch /etc/modprobe.d/nvidia.conf
                echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp/ NVreg_EnableGpuFirmware=0" | sudo tee -a /etc/modprobe.d/nvidia.conf > /dev/null
                    warning "Created: nvidia.conf"
            fi
            if [ ! -e "/etc/modprobe.d/nvidia_drm.conf" ]; then
                sudo touch /etc/modprobe.d/nvidia_drm.conf
                echo "options nvidia_drm modeset=1 fbdev=1" | sudo tee -a /etc/modprobe.d/nvidia_drm.conf > /dev/null
                    warning "Created: nvidia_drm.conf"
            fi
                
            echo "LIBVA_DRIVER_NAME=nvidia" | sudo tee -a /etc/environment > /dev/null
                warning "Set: LIBVA_DRIVER_NAME=nvidia"
            echo "__GLX_VENDOR_LIBRARY_NAME=nvidia" | sudo tee -a /etc/environment > /dev/null
                warning "Set: __GLX_VENDOR_LIBRARY_NAME=nvidia"
            echo "NVD_BACKEND=direct" | sudo tee -a /etc/environment > /dev/null
                warning "Set: NVD_BACKEND=direct"
            
            enableService "nvidia-suspend"
                warning "Enabled nvidia-suspend.service"
            enableService "nvidia-hibernate"
                warning "Enabled nvidia-hibernate.service"
            enableService "nvidia-resume"
                warning "Enabled nvidia-resume.service"
                
            sudo systemctl daemon-reload

            sudo mkinitcpio -P
            section_end
    fi

    draw_section "Electron: Ozone Wayland Flag"
        echo "ELECTRON_OZONE_PLATFORM_HINT=wayland" | sudo tee -a /etc/environment > /dev/null
            warning "Set: ELECTRON_OZONE_PLATFORM_HINT=wayland"
            warning "If you encounter Problems, set: ELECTRON_OZONE_PLATFORM_HINT=auto"
    section_end

    draw_section "Starting Services"
        modprobe btusb
        enableService "bluetooth"
        startService "bluetooth"
        warning "Bluetooth Service started"
        
        enableService "cups"
        startService "cups"
        enableService "cups.socket"
        warning "Cups Service started"
    section_end

    draw_section "Starting Firewall"
        sudo ufw default reject
        sudo ufw enable
        enableService "ufw"
        warning "Firewall started!"
    section_end

    draw_section "Starting AppArmor"
        enableService "apparmor"
        warning "Apparmor started!"
    section_end

    draw_section "Setting Shell"
        chsh -s $(which zsh)
        copyFiles "ln -sf" "config/.zshrc" "/home/$(echo $USER)/"
        warning "Setting ZShell as default shell!"
    section_end

    draw_section "Setting Starship"
        copyFiles "ln -sf" "config/starship.toml" "/home/$(echo $USER)/.config/"
        warning "Setting Starship custom theme!"
    section_end

    draw_section "Configure systemd-oomd"
        if [[ "$DESKTOP_ENV" == *"gnome"* ]]; then
            if [ ! -e "/etc/systemd/system/gnome-shell.oomd" ]; then
                sudo touch /etc/systemd/system/gnome-shell.oomd
                echo -e "[Unit]\nDescription=GNOME Shell OOMD Configuration\n\n[OOMD]\nDefaultAction=none" | sudo tee /etc/systemd/system/gnome-shell.oomd > /dev/null
                warning "Created exception for Gnome Shell"
            fi
        elif [[ "$DESKTOP_ENV" == *"kde"* || "$DESKTOP_ENV" == *"plasma"* ]]; then
            if [ ! -e "/etc/systemd/system/plasma-desktop.oomd" ]; then
                sudo touch /etc/systemd/system/plasma-desktop.oomd
                echo -e "[Unit]\nDescription=KDE Plasma OOMD Configuration\n\n[OOMD]\nDefaultAction=none" | sudo tee /etc/systemd/system/plasma-desktop.oomd > /dev/null
                warning "Created exception for KDE Plasma"
            fi
        fi
        echo "DefaultMemoryPressureLimit=70%" | sudo tee -a /etc/systemd/oomd.conf > /dev/null
            warning "Set: DefaultMemoryPressureLimit to 70%"
        echo "SwapUsedLimit=80%" | sudo tee -a /etc/systemd/oomd.conf > /dev/null
            warning "Set: SwapUsedLimit to 70%"
        echo "DefaultMemoryPressureDurationSec=30s" | sudo tee -a /etc/systemd/oomd.conf > /dev/null
            warning "Set: DefaultMemoryPressureDurationSec tot 30s"

        enableService "systemd-oomd"
            warning "Enabled systemd-oomd"
        startService "systemd-oomd"
            warning "Start systemd-oomd"
    section_end

    if [[ $tmux == 1 ]]; then
        draw_section "Installing tmux"
            sudo pacman -S --needed --noconfirm tmux
            warning "Installing: tmux"
            git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
            warning "Installing: tmux Plugin Manager"
            copyFiles "ln -sf" "config/tmux/.tmux.conf" "/home/$(echo $USER)/"
            warning "Copying: tmux config"
        section_end
    fi

    if [[ $ghostty == 1 ]]; then
        draw_section "Installing ghostty"
            sudo pacman -S --needed --noconfirm ghostty
            warning "Installing: ghostty"
            mkdir -p /home/$(echo $USER)/.config/ghostty/
            copyFiles "ln -sf" "config/ghostty/config" "/home/$(echo $USER)/.config/ghostty/"
            warning "Copying: ghostty config"
        section_end
    fi


    if [[ $kitty == 1 ]]; then
        draw_section "Installing ghostty"
            sudo pacman -S --needed --noconfirm kitty
            warning "Installing: kitty"
            mkdir -p /home/$(echo $USER)/.config/kitty/
            copyFiles "ln -sf" "config/kitty/kitty.conf" "/home/$(echo $USER)/.config/kitty/"
            copyFiles "ln -sf" "config/kitty/current-theme.conf" "/home/$(echo $USER)/.config/kitty/"
            warning "Copying: kitty config"
        section_end
    fi
fi

if [[ $debug_skip == 1 ]]; then
    error "Installation skipped...!"
fi

if [[ $gaming == 1 ]]; then
    draw_section "Configuring Gaming"
        if lspci | grep -i "nvidia" > /dev/null; then
                sudo pacman -S --needed --noconfirm lib32-nvidia-utils
                    warning "Installed App: lib32-nvidia-utils"
                drawline
        fi
        for pkg in steam wine winetricks wine-mono lutris lib32-libxcomposite cabextract; do
            sudo pacman -S --needed --noconfirm "$pkg"
                warning "Installed App: $pkg"
            drawLine
        done
        # This will install the XBOX controller driver from the AUR.
        # You Can use that for any XBOX and PlayStation Controller.
        # I tested it with a PS3 Controller in Cyberpunk 2077.
        git clone https://aur.archlinux.org/xboxdrv.git
        cd xboxdrv
        makepkg -si
            warning "Installed AUR App: xboxdrv"
        cd .. && rm -rf xboxdrv
        drawLine
    section_end
fi

draw_section "Cleaning"
    sudo pacman -Scc --noconfirm
section_end

sudo mkinitcpio -P

error "To Finish Apparmor configuration, add Kernel Parameters manually!"
error "-> https://wiki.archlinux.org/title/AppArmor"
warning "Installation Finished"
warning "Press enter to continue"
read

reboot
