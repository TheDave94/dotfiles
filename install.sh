#!/bin/sh

echo "Start system configuration now."
echo "Press enter to continue..."
read
echo "---------------------------------------------------------------"

echo "----------------------------------"
echo "Performing a system update: pacman -Syu"
echo "----------------------------------"

sudo pacman -Syu

# Base Package installation
./base.sh
echo "---------------------------------------------------------------"

# AUR
./aur.sh
echo "---------------------------------------------------------------"

# App installation
./apps.sh
echo "---------------------------------------------------------------"

# config
./config.sh
echo "---------------------------------------------------------------"

# GitHub configuration
./git.sh
echo "---------------------------------------------------------------"
