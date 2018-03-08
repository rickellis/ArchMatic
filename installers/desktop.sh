#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Desktop
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

echo -e "${yellow}INSTALLING${reset} Desktop"

DKPKGS=(
        'xfce4'
        'xfce4-goodies'
)

for pkg in "${DKPKGS[@]}"
do
    # sudo pacman -S "$pkg" --noconfirm --needed

    echo " $pkg"
done
