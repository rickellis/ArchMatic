#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Xorg
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------


# NOTE: At some point it will likely make sense to use Wayland instead of Xorg

echo -e "${yellow}INSTALLING${reset} Xorg"

XPKGS=(
        'xorg-server'           # XOrg server
        'xorg-apps'             # XOrg apps group
        'xorg-server-xwayland'  # Wayland support for XOrg
        'xorg-xinit'            # XOrg init
        'xf86-video-intel'      # 2D/3D video driver
        'mesa'                  # Open source version of OpenGL
)


for pk in "${XPKGS[@]}"
do
    echo " $pk"
done
