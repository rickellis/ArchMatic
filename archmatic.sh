#!/bin/bash

function archchroot(){
	echo "arch-chroot /mnt /root"
	cp ${0} /mnt/root
	chmod 755 /mnt/root/$(basename "${0}")
	arch-chroot /mnt /root/$(basename "${0}") --chroot ${1} ${2}
	rm /mnt/root/$(basename "${0}")
	echo "exit"
}

function preinstall(){
    sh 0-preisntall.sh -i
}

function baseinstall(){
    archchroot 1-setup.sh
}

function userinstall(){
    source /mnt/root/ArchMatic/install.conf
	arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/ArchMatic/2-user.sh
	rm /mnt/root/$(basename "${0}")
	echo "exit"
}

function postinstall(){
    archchroot 3-post-setup.sh
}

##
# Color  Variables
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Color Functions
##

ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}

### display main menu ###
menu(){
echo -ne "
Arch Titus Setup Script
$(ColorGreen '1)') Pre-Install - Format, Erase, and Ready Install
$(ColorGreen '2)') Base Setup - Install Packages and Environment
$(ColorGreen '3)') User Setup - Extra Packages and Customization
$(ColorGreen '4)') Post-Install - Cleanup and Ready First Boot
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
        read a
        case $a in
	        1) preinstall ; menu ;;
	        2) baseinstall ; menu ;;
	        3) userinstall ; menu ;;
	        4) postinstall ; menu ;;
			0) exit 0 ;;
			*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}

# call menu
menu
