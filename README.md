# Archomatic
Arch Linux Post Installation Setup and Configuration Scripts.

This README contains the steps I do to configure and set up a new installation.

The shell scripts in this repo allow automated package and desktop environment installation.

The install steps are as follows:

### Install Arch Linux

Follow the steps in my __[Arch Linux Installation Gude](https://github.com/rickellis/Arch-Linux-Install-Guide)__.

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

---

### Clone Archomatic
These are the scripts in this repo.

    $   git clone https://github.com/rickellis/Archomatic.git

---

### Run Archomatic files

Run the following scripts:

    $   ./1-xorg.sh
    $   ./2-xfce.sh 
    $   ./3-network.sh 
    $   ./4-bluetooth.sh 
    $   ./5-audio.sh 
    $   ./6-printers.sh 
    $   ./7-software-pacman.sh
    $   ./8-software-aur.sh
    $   ./9-setup.sh

### Reboot

    $   reboot

### Initialize Xorg:
At the terminal, run:

    $   xinit

If it doesn't automatically boot into XFCE run:

    $   startx


You should now have an Arch system running XFCE.

Congrats!