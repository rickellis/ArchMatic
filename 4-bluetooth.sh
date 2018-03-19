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
echo "Done!"
echo