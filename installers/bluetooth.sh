#!/usr/bin/env bashs
#-----------------------------------------------------------------------------------
#  Bluetooth
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

echo -e "${yellow}INSTALLING${reset} Bluetooth"



BTPKGS=(
        'pulseaudio-bluetooth'
        'bluez'
        'bluez-libs'
        'bluez-utils'
        'bluez-firmware'
        'blueberry'

)


for pkg in "${BTPKGS[@]}"
do
    # sudo pacman -S "$pkg" --noconfirm --needed

    echo " $pkg"
done


# sudo systemctl enable bluetooth.service
# sudo systemctl start bluetooth.service

# sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
