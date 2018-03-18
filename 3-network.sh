#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo
echo "INSTALLING NETWORK PACKAGES"
echo

# NOTE: Do I need: networkmanager-openvpn
# Or is networkmanager-vpnc all I need for VPN?

PKGS=(
        'wpa_supplicant'
        'dialog'
        'networkmanager'
        'openvpn'
        'networkmanager-vpnc'
        'network-manager-applet'
        'dhclient'
        'libsecret'
        'gnome-keyring'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done



echo
echo "NETWORK SETUP"
echo
echo "Find your IP Link name:"
echo

ip link

echo
read -p "ENTER IP LINK: " LINK

echo
echo "Enabling Network Manager"
echo

sudo systemctl disable dhcpcd.service
sudo systemctl stop dhcpcd.service
sudo ip link set dev ${LINK} down
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service
sudo ip link set dev ${LINK} up

echo "Done!"
echo 
