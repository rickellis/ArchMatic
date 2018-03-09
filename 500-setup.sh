#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo "PERFORMING SETUP AND CONFIGURATION"


# Get IP LINK using: ip link
LINK="wlp58s0"

#--------------------------------------------------------------------------

# Enable NetworkManger and disable dhcpcd

echo "Enabling network manager"

sudo systemctl disable dhcpcd.service
sudo systemctl stop dhcpcd.service
sudo ip link set dev ${LINK} down
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

#--------------------------------------------------------------------------

echo "Enabling lm_sensors"

# Enable lm_sensors
systemctl enable lm_sensors.service

#--------------------------------------------------------------------------

# Enable Autologin

echo "Enabling Autologin"
sudo gpasswd -a rickellis autologin
sudo sed -i 's/'#autologin-user='/'autologin-user=rickellis'/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/'#autologin-session='/'autologin-session=xfce'/g' /etc/lightdm/lightdm.conf
