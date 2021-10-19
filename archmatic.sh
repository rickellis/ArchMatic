#!/bin/bash

    bash 0-preinstall.sh
    arch-chroot /mnt/ -c /root/ArchMatic/1-setup.sh
    source /mnt/root/ArchMatic/install.conf
	arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/ArchMatic/2-user.sh
    archchroot 3-post-setup.sh
