#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Video
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

# To check driver use:
# lspci | grep VGA

echo -e "${yellow}INSTALLING${reset} Video Drivers"

VIDPKGS=(
        'xf86-video-intel'  # 2D/3D video driver
        'mesa'              # Open source version of OpenGL
)

for pkg in "${VIDPKGS[@]}"
do
    # sudo pacman -S "$pkg" --noconfirm --needed

    echo " $pkg"
done
