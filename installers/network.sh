#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Network
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

# Get IP LINK using: ip link
LINK="wlp58s0"

echo -e "${yellow}INSTALLING${reset} Network"

NMPKGS=(
        'wpa_supplicant'
        'networkmanager'
        'networkmanager-vpnc'
        # 'networkmanager-openvpn' # Not sure if this is needed if networkmanager-vpnc is installed
        'dhclient'
        'libsecret'
        'network-manager-applet'
        'gnome-keyring'
        'dialog'
)

for pkg in "${NMPKGS[@]}"
do
    # sudo pacman -S "$pkg" --noconfirm --needed

    echo " $pkg"
done


# Enable NetworkManger and disable dhcpcd

    #   sudo systemctl disable dhcpcd.service
    #   sudo systemctl stop dhcpcd.service
    #   sudo ip link set dev ${LINK} down
    #   sudo systemctl enable NetworkManager.service
    #   sudo systemctl start NetworkManager.service

