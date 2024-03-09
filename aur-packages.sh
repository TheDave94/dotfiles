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
    y ${app}
done


echo "---------------------------------------------------------------"

sdks=(
    "jdk-temurin"
)

for sdk in "${sdks[@]}"; do
    echo "----------------------------------"
    echo "Installing SDK: ${sdk}"
    echo "----------------------------------"
    y ${sdk}
done


echo "---------------------------------------------------------------"

fonts=(
    "sf-fonts"
)

for font in "${fontss[@]}"; do
    echo "----------------------------------"
    echo "Installing Font: ${font}"
    echo "----------------------------------"
    y ${font}
done
