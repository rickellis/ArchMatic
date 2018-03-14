# Archomatic
Arch Linux Post Installation Setup and Configuration Scripts.

This README contains all of the steps I do to fully configure and setup a new installation.

The shell scripts in this repo allow me to automate the package installation.

These steps will likely not work for you...

...but they might help you develop your own installers.


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

01-git-setup.sh 
02-xorg-xfce.sh 
03-network.sh 
04-bluetooth.sh 
05-audio.sh 
06-printers.sh 

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

---

### Initialize Xorg:

    $   xinit

If it doesn't automatically boot into XFCE run:

    $   startx


You should now have an Arch system running XFCE. Congrats!

---

### Install Software

Run these scripts:

07-software-pacman.sh
08-software-aur.sh

---

### Launch Firefox

Then verify the name of the folder where we put the `chrome` folder so we can update `personal-setup.sh`

---

### Run 10-personal-setup.sh

---

### Copy local themes to system

In order for some windows to recognize our theme choice we need to copy:

    ~/.local/share/themes/*

And paste them here:

    /usr/share/themes

---

### Enable Network Time Protocol

This package allows our system to update its clock via the network. This is especially useful if you travel.

    $   sudo ntpd -qg

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

Move slimlock themes into:

    /usr/share/slim/themes

Create slimlock config file: 

    /etc/slimlock.conf

Put this in it:

    dpms_standby_timeout            60
    dpms_off_timeout                600
    wrong_passwd_timeout            1
    passwd_feedback_x               8%
    passwd_feedback_y               54%
    passwd_feedback_msg             Authentication failed
    passwd_feedback_capslock        Authentication failed (CapsLock is on)
    show_username                   0
    show_welcome_msg                0
    tty_lock                        0
    current_theme                   wall

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

### PHP SETUP

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

---

### MariaDB SETUP

    sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    systemctl enable mysqld

COMMANDS

    systemctl start mysqld

    systemctl start mysqld

    systemctl status mysqld

CHANGE ROOT PASSWORD:

First start mysql, then:

    mysql_secure_installation
