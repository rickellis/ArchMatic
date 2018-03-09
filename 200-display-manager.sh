#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo "INSTALLING DISPLAY MANAGER"

PKGS=(
        'lightdm'
        'lightdm-gtk-greeter'
        'lightdm-gtk-greeter-settings'
)

for PKG in "${PKGS[@]}"; do

    echo "INSTALLING: ${PKG}"

    # sudo pacman -S "$PKG" --noconfirm --needed
done


sudo systemctl enable lightdm.service -f
sudo systemctl set-default graphical.target
