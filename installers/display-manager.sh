#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Display Manager
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

echo -e "${yellow}INSTALLING${reset} Display Manager"



DMPKGS=(
        'lightdm'
        'lightdm-gtk-greeter'
        'lightdm-gtk-greeter-settings'
)

for pkg in "${DMPKGS[@]}"
do
    # sudo pacman -S "$pkg" --noconfirm --needed

    echo " $pkg"
done


# sudo systemctl enable lightdm.service -f
# sudo systemctl set-default graphical.target


read -p "Enter your username for autologin: " USRNAME

# sudo gpasswd -a $USRNAME autologin

# sudo sed -i 's/'#autologin-user='/'autologin-user=$USRNAME'/g' /etc/lightdm/lightdm.conf
# sudo sed -i 's/'#autologin-session='/'autologin-session=xfce'/g' /etc/lightdm/lightdm.conf