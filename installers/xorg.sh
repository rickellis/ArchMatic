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
        'xorg-xinit'            # XOrg init
)


for pkg in "${XPKGS[@]}"
do
    # sudo pacman -S "$pkg" --noconfirm --needed

    echo " $pkg"
done
