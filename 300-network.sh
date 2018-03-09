#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo "INSTALLING NETWORK PACKAGES"

# NOTE: Do I need: networkmanager-openvpn
# Or is networkmanager-vpnc all I need for VPN?

PKGS=(
        'wpa_supplicant'
        'dialog'
        'networkmanager'
        'network-manager-applet'
        'networkmanager-vpnc'
        'dhclient'
        'libsecret'
        'gnome-keyring'
)

for PKG in "${PKGS[@]}": do

    echo "INSTALLING: ${PKG}"

    # sudo pacman -S "$PKG" --noconfirm --needed
done
