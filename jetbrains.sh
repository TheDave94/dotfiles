#!/bin/sh

pkgs=(
  "rustrover"
  "rustrover-jre"
  "webstorm"
  "webstorm-jre"
  "goland-eap"
  "goland-eap-jre"
  "clion-eap"
  "clion-eap-jre"
  "intellij-idea-ue-eap"
)

echo "--- Installing JetBrains Tools ---"

for pkg in ${pkgs[@]}; do
  echo "-- Installing: $pkg"
  yay -S --needed --noconfirm ${pkg}
done
