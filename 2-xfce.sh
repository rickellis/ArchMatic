#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#-------------------------------------------------------------------------

echo
echo "INSTALLING XFCE"
echo

PKGS=(
        'xfce4'                 # XFCE Desktop
        'xfce4-goodies'         # All the extras
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

# ------------------------------------------------------------------------

# Generate the .xinitrc file so we can launch XFCE from the
# terminal using the "startx" command. I don't typically run a greeter on my
# Arch installs (the greeter is the login screen you see after bootup). 
# The reason I don't is because I like my computer to boot into the terminal
# by default, rather than a GUI.

echo
echo "Genaerating .xinitrc file"

if [ ! -d ${HOME}/.xinitrc ]; then
    touch ${HOME}/.xinitrc
fi

cat <<EOF > ${HOME}/.xinitrc
#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
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
sudo sed -i -e 's|xserverauthfile=\$HOME/.serverauth.\$\$|xserverauthfile=\$XAUTHORITY|g' /bin/startx

echo
echo "Done!"
echo