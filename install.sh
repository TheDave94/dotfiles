
#!/bin/bash

# -----------------------------------------------#
#               Config Section                   # 
# -----------------------------------------------#

nvidia=1
flatpak=1
wlan=0

# -----------------------------------------------#
#                      Debug                     #
#         You may want to let it as it is!       #
# -----------------------------------------------#

# You may want to change this, when you installed
# your system, but forgot to install gaming.
# You can skip initial set up and jump to gaming

debug_skip=0

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

message "Welcome to FoxFiles on Fedora Silverblue."

draw_section "Update System"
    sudo rpm-ostree update && sudo rpm-ostree upgrade
section_end

if [[ $debug_skip == 0 ]]; then
    DESKTOP_ENV=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')
    if [[ "$DESKTOP_ENV" == *"gnome"* ]]; then
        draw_section "Gnome: Fractional Scaling"
            gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'xwayland-native-scaling']"
            warning "Gnome: Fractional Scaling Enabled"
        section_end
        draw_section "Gnome: Removing Apps"
            for app in gnome-tour yelp; do
                sudo rpm-ostree override remove "$app"
                warning "Removed App: $app"
            done
    fi

    if [[ $flatpak == 1 ]]; then
    	draw_section "Removing Flatpaks"
            for app in org.gnome.Contacts org.gnome.Weather org.gnome.clocks org.gnome.Maps org.gnome.Characters; do
            	flatpak remove -y "$app"
            	warning "Removed Flatpak: $app"
            done
        section_end
    	draw_section "Update Flatpaks"
            flatpak update -y
            warning "Updated Flatpak"
        section_end
        draw_section "Installing Flatpaks"
            installPackages "flatpak.txt" "flatpak install -y flathub"
        section_end
    fi

    if type rpm-ostree &> /dev/null; then
        draw_section "Installing Basic Packages"
            installPackages "ostree.txt" "sudo rpm-ostree install"
        section_end
    fi
    
    draw_section "Remove Firefox"
        sudo rpm-ostree override remove firefox firefox-langpacks
        for folder in ~/.mozilla/firefox ~/.cache/mozilla/firefox ~/.config/mozilla ~/.local/share/mozilla /etc/firefox /usr/lib/firefox /usr/share/firefox; do
            sudo rm -rf "$folder"
            warning "Delete Folder: $folder"
        done 
    section_end
    
    if [[ $nvidia == 1 ]]; then
    	draw_section "Nvidia Setup"
		sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia-cuda
			warning "Installed nvidia Driver"
		sudo rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1 --append=nvidia-drm.fbdev=1 --append=nvidia.NVreg_PreserveVideoMemoryAllocations=1 --append=nvidia.NVreg_TemporaryFilePath=/.nvtmp
			warning "Blacklisted Nouveau."
			warning "Activated Nvidia Modesetting."	
			warning "Activated Nvidia Hibernation."	
		echo "LIBVA_DRIVER_NAME=nvidia" | sudo tee -a /etc/environment > /dev/null
        		warning "Set: LIBVA_DRIVER_NAME=nvidia"
        	echo "__GLX_VENDOR_LIBRARY_NAME=nvidia" | sudo tee -a /etc/environment > /dev/null
                	warning "Set: __GLX_VENDOR_LIBRARY_NAME=nvidia"
        	echo "NVD_BACKEND=direct" | sudo tee -a /etc/environment > /dev/null
                	warning "Set: NVD_BACKEND=direct"
        section_end
    fi
    
    if [[ $wlan == 1 ]]; then
    	draw_section "W-LAN Setup"
    	sudo rpm-ostree install iwd
    	echo "[device]\nwifi.backend=iwd" | sudo tee -a /etc/NetworkManager/conf.d/iwd.conf > /dev/null
	sudo systemctl restart NetworkManager
        section_end
    fi
    
    draw_section "Electron: Ozone Wayland Flag"
        echo "ELECTRON_OZONE_PLATFORM_HINT=wayland" | sudo tee -a /etc/environment > /dev/null
            warning "Set: ELECTRON_OZONE_PLATFORM_HINT=wayland"
            warning "If you encounter Problems, set: ELECTRON_OZONE_PLATFORM_HINT=auto"
    section_end

    draw_section "Mozilla: Wayland Flag"
        echo "MOZ_ENABLE_WAYLAND=1" | sudo tee -a /etc/environment > /dev/null
            warning "Set: MOZ_ENABLE_WAYLAND=1"
    section_end

    draw_section "Setting Shell"
        chsh -s $(which zsh)
        copyFiles "ln -sf" "config/.zshrc" "/home/$(echo $USER)/"
        warning "Setting ZShell as default shell!"
    section_end
fi

sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

warning "Installation Finished"
warning "Press enter to continue"
read

systemctl reboot
