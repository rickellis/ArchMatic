#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#-------------------------------------------------------------------------

echo
echo "INSTALLING BLUETOOTH COMPONENTS"
echo

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
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "ENABLING BLUETOOTH AUTOSTART"
echo

sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

echo
echo "SYSTEMCTL STARTING BLUETOOTH SERVICE"
echo

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

echo
echo "Done!"
echo