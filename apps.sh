#!/bin/sh

apps=(
    "chromium"
    "bitwarden"
    "discord"
    "flameshot"
    "virtualbox-host-modules-arch"
    "virtualbox"
    "gufw"
    "tilix"
)

sdks=(
    "cmake"
    "clang"
    "ninja"
    "gdb"
    "nodejs"
    "npm"
    "python"
)

fonts=(
    "ttf-meslo-nerd"
    "powerline-fonts"
    "noto-fonts-cjk"
    "noto-fonts-extra"
    "noto-fonts-emoji"
    "ttf-hack-nerd"
    "ttf-jetbrains-mono-nerd"
    "ttf-ibmplex-mono-nerd"
)

flatpaks=(
    "com.todoist.Todoist"
    "com.spotify.Client"
    "com.mattjakeman.ExtensionManager"
)

aur_apps=(
    "visual-studio-code-bin"
    "intellij-idea-ultimate-edition"
    "brother-mfc-l2710dw"
    "microsoft-edge-stable-bin"
)

aur_sdks=(
    "jdk-temurin"
)

aur_fonts=(
    "sf-fonts"
)


echo "Start software installation on the system."
echo "From here on, some things need to be confirmed!"
echo "Press enter to continue..."
read

echo "---------------------------------------------------------------"

for app in "${apps[@]}"; do
    echo "----------------------------------"
    echo "Installing app: ${app}"
    echo "----------------------------------"
    sudo pacman -S --needed --noconfirm ${app}
done

echo "---------------------------------------------------------------"

for sdk in "${sdks[@]}"; do
    echo "----------------------------------"
    echo "Installing SDK: ${sdk}"
    echo "----------------------------------"
    sudo pacman -S --needed --noconfirm ${sdk}
done

echo "---------------------------------------------------------------"

for font in "${fonts[@]}"; do
    echo "----------------------------------"
    echo "Installing font: ${font}"
    echo "----------------------------------"
    sudo pacman -S --needed --noconfirm ${font}
done

echo "---------------------------------------------------------------"

for flatpak in "${flatpaks[@]}"; do
    echo "----------------------------------"
    echo "Installing flatpak: ${flatpak}"
    echo "----------------------------------"
    flatpak install flathub ${flatpak}
done

echo "---------------------------------------------------------------"

for aur_app in "${aur_apps[@]}"; do
    echo "----------------------------------"
    echo "Installing AUR-app: ${aur_app}"
    echo "----------------------------------"
    yay -S --noconfirm ${aur_app}
done

echo "---------------------------------------------------------------"

for aur_sdk in "${aur_sdks[@]}"; do
    echo "----------------------------------"
    echo "Installing AUR-app: ${aur_sdk}"
    echo "----------------------------------"
    yay -S --noconfirm ${aur_sdk}
done

echo "---------------------------------------------------------------"

for aur_font in "${aur_fonts[@]}"; do
    echo "----------------------------------"
    echo "Installing AUR-app: ${aur_font}"
    echo "----------------------------------"
    yay -S --noconfirm ${aur_font}
done