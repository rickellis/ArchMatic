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
echo "Done!"
echo
