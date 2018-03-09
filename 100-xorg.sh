#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#-------------------------------------------------------------------------

echo "INSTALLING XORG"

PKGS=(
        'xorg-server'   # XOrg server
        'xorg-apps'     # XOrg apps group
        'xorg-xinit'    # XOrg init
)


for PKG in "${PKGS[@]}"; do

    echo "INSTALLING: ${PKG}"

    # sudo pacman -S "$PKG" --noconfirm --needed
done
