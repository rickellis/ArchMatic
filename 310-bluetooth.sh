#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#-------------------------------------------------------------------------

echo "INSTALLING BLUETOOTH COMPONENTS"

PKGS=(
        'pulseaudio-bluetooth'
        'bluez'
        'bluez-libs'
        'bluez-utils'
        'bluez-firmware'
        'blueberry'
)


for PKG in "${PKGS[@]}"; do

    echo "INSTALLING ${PKG}"

    # sudo pacman -S "$PKG" --noconfirm --needed
    
done


# sudo systemctl enable bluetooth.service
# sudo systemctl start bluetooth.service

# sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
