#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo "INSTALLING VIDEO DRIVERS"

PKGS=(
        'xf86-video-intel'      # 2D/3D video driver
        'mesa'                  # Open source version of OpenGL
        'xf86-input-libinput'   # Trackpad driver for Dell XPS
)

for PKG in "${PKGS[@]}"; do

    echo "INSTALLING ${PKG}"
    
    # sudo pacman -S "$PKG" --noconfirm --needed

done
