#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo
echo "INSTALLING DESKTOP"
echo

PKGS=(
        #'lightdm'
        #'lightdm-gtk-greeter'
        #'lightdm-gtk-greeter-settings'
        'xfce4'
        'xfce4-goodies'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done




# cd ${HOME}/CodeLab/AURIC
# chmod +x auric.sh
# ./auric.sh -i lightdm-mini-greeter


# # Enable LightDM
# sudo systemctl enable lightdm.service -f

# systemctl start lightdm.service

# # Launch the GUI by default
# sudo systemctl set-default graphical.target


# echo
# echo
# echo "To configure Lightdm:"
# echo
# echo "sudo nano /etc/lightdm/lighdm.conf"
# echo
# echo "greeter-session=lightdm-mini-greeter"
# echo "user-session=xfce"
# echo
# echo
# echo "Then configure lightdm-mini-greeter:"
# echo
# echo "sudo nano /etc/lightdm/lighdm-mini-greeter.conf"
# echo
# echo 'user = rickellis'
# echo 'show-password-label = false'
# echo 'password-label-text = ""'
# echo
# echo 'shutdown-key = x'
# echo 'restart-key = r'
# echo 'hibernate-key = h'
# echo 'suspend-key = s'
# echo
# echo 'background-color = "#111111"'
# echo 'window-color = "#333333"'
# echo 'border-color = "#666666"'
# echo 'password-background-color = "#000000"'
# echo
# echo


