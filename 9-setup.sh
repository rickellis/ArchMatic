#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo
echo "SETUP AND CONFIGURATION"
echo

# ------------------------------------------------------------------------

echo "Configuring LTS Kernel as a secondary boot option"

# Install LTS Kernel
# Create a copy of the arch.conf file
sudo touch /boot/loader/entries/arch-lts.conf

# Add the relevant info
sudo cat <<EOF > /boot/loader/entries/arch-lts.conf
title   Arch Linux LTS Kernel
linux   /vmlinuz-linux-lts
initrd  /intel-ucode.img
initrd  /initramfs-linux-lts.img
EOF

# ------------------------------------------------------------------------

echo "Enabling Network Time Protocol"

### Enable Network Time Protocol to we can set clock via network
sudo ntpd -qg
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

# ------------------------------------------------------------------------

echo "Configuring vconsole.conf to set a default login terminal font size"

# Create vconsole.config
# This lets us use larger console fonts in TT1

sudo touch /etc/vconsole.conf
sudo cat <<EOF > /etc/vconsole.conf
KEYMAP=us
FONT=ter-v32b
EOF


# ------------------------------------------------------------------------

echo "Disabling buggy cursor inheritance"

# Fix giant cursor problem

sudo cat <<EOF > /usr/share/icons/default/index.theme
[Icon Theme]
#Inherits=Theme
EOF



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
echo "Reboot now"
echo