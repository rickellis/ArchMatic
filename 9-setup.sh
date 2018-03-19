#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo
echo "SETUP AND CONFIGURATION"
echo

# ------------------------------------------------------------------------

# Generate the .xinitrc file so we can launch XFCE from the
# terminal using the "startx" command. I don't typically run a greeter on my
# Arch installs (the greeter is the login screen you see after bootup). 
# The reason I don't is because I like my computer to boot into the terminal
# by default, rather than a GUI.

echo
echo "Genaerating .xinitrc file"

cat <<EOF > ${HOME}/.xinitrc
#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "\$f" ] && . "\$f"
    done
    unset f
fi

source /etc/xdg/xfce4/xinitrc
exit 0
EOF

# ------------------------------------------------------------------------

# By default, startx looks for the .serverauth file in our HOME folder. Since it's 
# not there it generates a new one every time we log in. However, each login creates a
# unique ID which gets added to the name, so over time we end up with a build-up of 
# these files. This code updates the path so this doesn't happen.

echo
echo "Updating /bin/startx"
sudo sed -i 's|xserverauthfile=\$HOME/.serverauth.\$\$|xserverauthfile=\$XAUTHORITY|g' /bin/startx

# ------------------------------------------------------------------------

echo
echo "Configuring LTS Kernel as a secondary boot option"

# Make a copy of the boot loader
sudo cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf

# Swap various values
sudo sed -i 's|Arch Linux|Arch Linux LTS Kernel|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|vmlinuz-linux|vmlinuz-linux-lts|g' /boot/loader/entries/arch-lts.conf
sudo sed -i 's|initramfs-linux.img|initramfs-linux-lts.img|g' /boot/loader/entries/arch-lts.conf

# ------------------------------------------------------------------------

echo
echo "Configuring vconsole.conf to set a default login terminal font size"

# Create vconsole.config
# This lets us use larger console fonts in TT1
sudo cat <<EOF > /etc/vconsole.conf
KEYMAP=us
FONT=ter-v32b
EOF

# ------------------------------------------------------------------------

echo
echo "Disabling buggy cursor inheritance"

# Fix giant cursor problem

sudo cat <<EOF > /usr/share/icons/default/index.theme
[Icon Theme]
#Inherits=Theme
EOF

# ------------------------------------------------------------------------

# Increase the number of file watchers.
# This prevents a "too many files" error in Visual Studio Code

echo
echo "Increasing file watcher count"

echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system

# ------------------------------------------------------------------------

echo
echo "Disabling Pulse .esd_auth module"

# Disallow .esd_auth
# Pulse audio loads the `esound-protocol` module, which best I can tell is rarely needed.
# That module creates a file called `.esd_auth` in the home directory which I'd prefer to not be there. So...

sudo sed -i 's|load-module module-esound-protocol-unix|#load-module module-esound-protocol-unix|g' /etc/pulse/default.pa

# ------------------------------------------------------------------------

echo
echo "Enabling bluetooth auto-start"

sudo sed -i 's|#AutoEnable=false|AutoEnable=true|g' /etc/bluetooth/main.conf


echo
echo "Starting systemctl bluetooth service"

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# ------------------------------------------------------------------------

echo
echo "Enabling systemctl cups.service"
echo

systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service

# ------------------------------------------------------------------------

### Enable Network Time Protocol to we can set clock via network

echo
echo "Enabling Network Time Protocol"

sudo ntpd -qg
sudo systemctl enable ntpd.service
sudo systemctl start ntpd.service

# ------------------------------------------------------------------------

# Configure Network Manager

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