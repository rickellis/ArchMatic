#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo "INSTALLING DESKTOP"

PKGS=(
        'xfce4'
        'xfce4-goodies'
)

for PKG in "${PKGS[@]}"; do

    echo "INSTALLING ${PKG}"

    # sudo pacman -S "$PKG" --noconfirm --needed

done
