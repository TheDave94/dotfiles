#!/bin/sh

echo "Start AUR-Apps installation now."
echo "Press enter to continue..."
read
echo "---------------------------------------------------------------"

apps=(
    "visual-studio-code-bin"
    "intellij-idea-ultimate-edition"
    "brother-mfc-l2710dw"
)

for app in "${apps[@]}"; do
    echo "----------------------------------"
    echo "Installing app: ${app}"
    echo "----------------------------------"
    yay -S --noconfirm ${app}
done


echo "---------------------------------------------------------------"

sdks=(
    "jdk-temurin"
)

for sdk in "${sdks[@]}"; do
    echo "----------------------------------"
    echo "Installing SDK: ${sdk}"
    echo "----------------------------------"
    yay -S --noconfirm ${sdk}
done


echo "---------------------------------------------------------------"

fonts=(
    "sf-fonts"
)

for font in "${fontss[@]}"; do
    echo "----------------------------------"
    echo "Installing Font: ${font}"
    echo "----------------------------------"
    yay -S --noconfirm ${font}
done
