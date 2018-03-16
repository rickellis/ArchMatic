# Archomatic
Arch Linux Post Installation Setup and Configuration Scripts.

This README contains all of the steps I do to fully configure and setup a new installation.

The shell scripts in this repo allow me to automate the package and desktop environment installation.

### Install Arch Linux

Follow the stops in my __[Arch Linux Installation Gude](https://github.com/rickellis/Arch-Linux-Install-Guide)__.

---

### Boot into new installation, and:

    $   sudo wifi-menu

---

### Install Reflector. 

First update the databases:

    $   sudo pacman -Sy

    $   sudo pacman -S reflector rsync curl

Now generate mirrorlist:

    $   reflector --verbose --country 'United States' -l 5 --sort rate --save /etc/pacman.d/mirrorlist

---

### Initialize .gitconfig file
    
    git config --global user.name "rickellis"
    git config --global user.email "rickellis@gmail.com"
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=31536000'

---

### Clone Archomatic

These are the scripts in this repo.

    $   mkdir /home/CodeLab

    $   git clone https://github.com/rickellis/Archomatic.git

---

### Run Archomatic files

Run the following scripts:

* 1-git-setup.sh 
* 2-xorg-xfce.sh 
* 3-network.sh 
* 4-bluetooth.sh 
* 5-audio.sh 
* 6-printers.sh 

Then reboot

---

### Start XORG and XFCE

Before we can run initialize Xorg, we neded to make sure we have a `.xinitrc` file in the home folder.

Create it and put this in it:

    #!/bin/bash

    if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
    done
    unset f
    fi

    source /etc/xdg/xfce4/xinitrc
    exit 0


Then update the __startx__ file so it won't pollute our home folder with `.serverauth` files.

Open:

    /bin/startx

And comment out:

    # xserverauthfile=$HOME/.serverauth.$$

And add:

    xserverauthfile=$XAUTHORITY

---

### Initialize Xorg:

    $   xinit

If it doesn't automatically boot into XFCE run:

    $   startx


You should now have an Arch system running XFCE.

Congrats!

---

### Install Software

Run these scripts:

* 7-software-pacman.sh
* 8-software-aur.sh

---

### Run 9-personal-setup.sh

__IMPORTANT:__ Before running the script, launch Firefox so it will create the `.mozilla` folder.

Then verify the name of the folder where we will put our Firefox CSS fix.

Update the personal setup script with this info, then run it.

---

### Copy local themes to system

In order for some XFCE system windows to recognize our theme choice we need to copy:

    ~/.local/share/themes/*

And paste them here:

    /usr/share/themes

---

### Enable Network Time Protocol

This package allows our system to update its clock via the network. This is especially useful if you travel.

    $   sudo ntpd -qg

Configure it to start at boot:

    $   sudo systemctl enable ntpd.service

    $   sudo systemctl start ntpd.service

---

### Create vconsole.config

For larger default terminal fonts create a config file at:

    $   sudo nano /etc/vconsole.config

In it, put this:

    KEYMAP=us
    FONT=ter-v32b

---

### Update font cache:

    $   sudo fc-cache -fv   # System fonts

    $   sudo fc-cache -fv ~/.fonts  $ Local fonts

---

### Install Slimlock Themes

Travel into the slim folder:

    cd /usr/share/slim

Then DELETE the existing themes folder:

    sudo rm -rf /usr/share/slim/themes

Create a symbolic link to the `home/rickellis/.slimlock-themes`

    sudo ln -s /home/rickellis/.slimlock-themes themes


Travel into etc

    cd /etc/

DELETE the `slimlock.conf` file

    sudo rm slimlock.conf

Create a symbolic link to the `slimlock.conf` file in the home config folder:

    sudo ln -s /home/rickellis/.config/slimlock/slimlock.conf slimlock.conf

---

### Set Laptop Lid Close to Suspend

     sudo nano /etc/systemd/logind.conf

Change this:

    HandleLidSwitch = suspend

---

### Firefox: Deactivate Middle Button Paste

     about:config
     middlemouse.paste = false
     middlemouse.opennewwindow = false


---

### Configre MAKEPKG to Use 8 Cores


    sudo nano /etc/makepkg.conf

And set these:

    MAKEFLAGS="-j$(nproc)"
    COMPRESSXZ=(xz -c -T 8 -z -)

---

### Giant Cursor Fix

To solve the giant cursor problem:

    $ sudo nano /usr/share/icons/default/index.theme

Comment OUT:

    [Icon Theme]
    #Inherits=Theme

----

### Disallow .esd_auth

Pulse audio loads the `esound-protocol` module, which best I can tell is rarely needed. That module creates a file called `.esd_auth` in the home directory which I'd prefer to not be there. So...

Edit:

    /etc/pulse/default.pa

And comment out:

    load-module module-esound-protocol-unix

----

### Setup SSH

    $   ssh-keygen -t rsa -b 4096 -C "rickellis@gmail.com"

Hit Enter to accept defaults

Then add the SSH key to the agent:

    $   ssh-add

----


### LTS Kernel Install

It's really handy to have both the rolling kernel and the LTS installed, so if the rolling one borks you can boot using the LTS.

Install LTS Kernel

    sudo pacman -S linux-lts

Make a copy of the arch.conf file

    cd /boot/loader/entries
    cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf

Edit the new conf file

    sudo nano /boot/loader/entries/arch-lts.conf

Add "lts" in various places

    title   Arch Linux LTS Kernel
    linux   /vmlinuz-linux-lts
    initrd  /intel-ucode.img
    initrd  /initramfs-linux-lts.img

---

### APACHE SETUP

Make a backup copy of the httpd.conf file:

    sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd-orig.conf

Replace httpd.conf with my custom one:

    sudo cp /home/rickellis/CodeLab/WebServer/httpd-conf/httpd-linux.conf /etc/httpd/conf/httpd.conf

Start Apache (using my bash script)

    $   apachestart

Or the old fashioned way:

    $   sudo apachectl start
    $   httpd -v

---

### MariaDB SETUP

    sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    sudo systemctl enable mysqld

COMMANDS

    systemctl start mysqld

    systemctl stop mysqld

    systemctl status mysqld

CHANGE ROOT PASSWORD:

First start mysql, then:

    mysql_secure_installation

---

### PHP SETUP

#### IMPORTANT: If you set up APACHE as indicated above, PHP will automatically be set up as well.

These instructions are just in case you need to set it up from scratch

Edit the httpd.conf file:

    /etc/httpd/conf/httpd.conf

Find the following line and COMMENT IT OUT:

#LoadModule mpm_event_module modules/mod_mpm_event.so


Then, add the following lines at the bottom:

    LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
    LoadModule php7_module modules/libphp7.so
    AddHandler php7-script php
    Include conf/extra/php7_module.conf

Then run:

    systemctl restart httpd


EDIT: 

    /etc/php/php.ini

Uncomment this:

    extension=mysqli

Add these:

    extension=bz2.so
    extension=mcrypt.so
