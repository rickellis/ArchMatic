#!/bin/bash

function archchroot(){
	echo "arch-chroot /mnt /root"
	cp ${0} /mnt/root
	chmod 755 /mnt/root/$(basename "${0}")
	arch-chroot /mnt /root/$(basename "${0}") --chroot ${1} ${2}
	rm /mnt/root/$(basename "${0}")
	echo "exit"
}

HEIGHT=15
WIDTH=80
CHOICE_HEIGHT=5
BACKTITLE="Like & Subscribe"
TITLE="Arch Titus Setup Script"
MENU="Choose one of the following options:"
TERMINAL=$(tty)

OPTIONS=(1 "Pre-Install - Format, Erase, and Ready Install"
         2 "Base Setup - Install Packages and Environment"
         3 "User Setup - Extra Packages and Customization"
		 4 "Post-Install - Cleanup and Ready First Boot")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >$TERMINAL)

clear
case $CHOICE in
        1)
            sh 0-preinstall.sh -i
            ;;
        2)
            archchroot 1-setup.sh
            ;;
        3)
            source /mnt/root/ArchMatic/install.conf
			arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/ArchMatic/2-user.sh
			rm /mnt/root/$(basename "${0}")
			echo "exit"
            ;;
		4)
			archchroot 3-post-setup.sh
			;;
esac

