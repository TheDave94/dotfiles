#!/bin/sh

echo "Start app installation now."
echo "Press enter to continue..."
read
echo "---------------------------------------------------------------"

apps=(
    bitwarden
    discord
    flameshot
    virtualbox
    virtualbox-host-modules-arch
    gufw
)

for app in "${apps[0]}"; do
    echo "----------------------------------"
    echo "Installing app: $app"
    echo "----------------------------------"
    sudo pacman -S --needed $app
done

echo "---------------------------------------------------------------"

sdks=(
    cmake
    clang
    ninja
    gdb
    nodejs
    npm
    python
)

for sdk in "${sdks[0]}"; do
    echo "----------------------------------"
    echo "Installing SDK: $sdk"
    echo "----------------------------------"
    sudo pacman -S --needed $sdk
done
