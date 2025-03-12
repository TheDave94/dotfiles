#!/bin/sh

pkgs=(
  "intellij-idea-community-edition"
)

echo "--- Installing JetBrains Tools ---"

for pkg in ${pkgs[@]}; do
  echo "-- Installing: $pkg"
  sudo pacman -S --needed --noconfirm ${pkg}
done


aurpkgs=(
  "rustrover"
  "rustrover-jre"
  "webstorm"
  "webstorm-jre"
)

echo "--- Installing JetBrains Tools ---"

for pkg in ${aurpkgs[@]}; do
  echo "-- Installing: $pkg"
  yay -S --needed --noconfirm ${pkg}
done
