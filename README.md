# Arch Linux Post Installation Setup and Config Scripts

<img src="https://i.imgur.com/uFysgdN.png" />

This README contains the steps I do to install and configure a fully-functional Arch Linux installation containing a desktop environment, all the support packages (network, bluetooth, audio, printers, etc.), along with all my preferred applications and utilities. The shell scripts in this repo allow the entire process to be automated.

Setting up an Arch system from scratch is usually a time-intensive process. My goal in developing these scripts and my __[installation guide](https://github.com/rickellis/Arch-Linux-Install-Guide)__ was to be able to go from a blank hard drive to a fully functional Arch system with all my files, applications, and preferences set, as efficiently as possible.

Titus Addition: (Install steps before running scripts)

Good How To Guides:

https://linoxide.com/distros/beginners-arch-linux-installation-guide/

https://www.2daygeek.com/install-xfce-mate-kde-gnome-cinnamon-lxqt-lxde-budgie-deepin-enlightenment-desktop-environment-on-arch-linux/


Install process

$ timedatectl set-ntp true

$ fdisk -l

$ cfdisk /dev/sda

*New Linux Partition
*Make disk bootable and write

$ mkfs.ext4 /dev/sda1

$ mount /dev/sda1 /mnt

$ pacstrap /mnt base base-devel

$ genfstab -U /mnt >> /mnt/etc/fstab

$ arch-chroot /mnt

Edit /etc/pacman.d/mirrorlist and re-organize per you geolocation
*Here is a handy command to do it for you if you reside in the United States change US to your country if not.

$ pacman -S --no-confirm pacman-contrib curl

$ git clone https://github.com/ChrisTitusTech/ArchMatic

$ cd ArchMatic

$ chmod +x *

$ ./0-setupmirrors.sh

Set Time Zone

$ ln -sf /usr/share/zoneinfo/US/Central /etc/localtime

$ hwclock --systohc


Set Language

Edit /etc/locale.gen and uncomment language

$ echo LANG=en_US.UTF-8 > /etc/locale.conf


Set Hostname

$ echo archlinux > /etc/hostname

Edit /etc/hosts


Setup Users 

$ useradd -m -G wheel,users -s /bin/bash titus

$ passwd

$ passwd titus

Edit /etc/sudoers

$ systemctl enable dhcpcd

Install GRUB

$ pacman -S grub

$ grub-install --recheck --target=i386-pc /dev/sda

$ grub-mkconfig -o /boot/grub/grub.cfg


$ exit

$ umount -R /mnt

$ reboot


Install Desktop Environment

$ sudo pacman -Syu

$ sudo pacman -S xorg xorg-server

sudo pacman -S xfce4 xfce4-goodies


Install Desktop Manager

$ sudo pacman -S lightdm

$ sudo pacman -S lightdm-gtk-greeter

Edit /etc/lightdm/lightdm.conf

greeter-session=lightdm-gtk-greeter

$ sudo systemctl enable lightdm.service

$ sudo systemctl start lightdm.service


OR login via shell

Edit $HOME/.bash_profile

if [ -z "$DISPLAY" ] && [ $(tty) == /dev/tty1 ]; then

  startx
  
fi


Edit $HOME/.xinitrc 

exec dbus-launch startxfce4 &>>/dev/null



### Don't just run these scripts. Examine them. Customize them. Create your own versions.

---

### System Description
I run XFCE desktop because it's fast, clean, and lightweight. I've tried nearly every other Linux desktop and a few window managers, but I keep coming back to XFCE.

I don't install a greeter, preferring to always boot into the login shell by default. That way if there is ever a show-stopping problem with Xorg or XFCE I can fix it without having to boot from an external drive. To launch XFCE I enter `startx` in the terminal. If you run multiple desktops you can pass a path argument to `startx` pointing to the initialization file for the desktop you want to run.

Since I don't use a greeter, to lock the screen I use Slimlock. I built a bunch of my own themes, and wrote a little shell script that randomizes the choice each time I lock the screen.

To boot I use `systemd` because it's minimalist, comes built-in, and since the Linux kernel has an EFI image, all we need is a way to execute it.

I also install the LTS Kernel along side the rolling one, and configure my bootloader to offer both as a choice during startup. This enables me to switch kernels in the event of a problem with the rolling one.

I don't run an application dock. The Whisker Menu (which I trigger via a shortcut) allows very fast lookup without needing a mouse. This is similar to Spotlight Search on Mac or the Start menu on Windows.

I set up my machines as development environments since that's mostly what I do. To that end I install lots of dev tools and customize various things to increase productivity. For exmple, I set up Apache server to run as me, with the WebServer directory located in my home folder.

I run my own utilites: __[WifiVPN](https://github.com/rickellis/WifiVPN)__ for network/VPN connectivity, __[AURIC](https://github.com/rickellis/AURIC)__ for AUR package management, and __[ConkyMatic](https://github.com/rickellis/ConkyMatic)__ to theme my Conky whenever I switch wallpaper.

---

The install steps are as follows:

### Install Arch Linux

Follow the steps in my __[Arch Linux Installation Gude](https://github.com/rickellis/Arch-Linux-Install-Guide)__. Then:

---

### Boot into new installation
And get online...

    $   sudo wifi-menu

---

### Install Reflector. 
Reflector allows the fastest Arch mirrors to be used.

    $   sudo pacman -Sy

    $   sudo pacman -S reflector rsync curl

Now generate mirrorlist. Note: If you are not in the U.S. change "United States" to your own country.

    $   reflector --verbose --country 'United States' -l 5 --sort rate --save /etc/pacman.d/mirrorlist

---

### Initialize .gitconfig file
So we can clone this repo...

    git config --global user.name "your-username"
    git config --global user.email "your-email@gmail.com"
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=31536000'

---

### Clone ArchMatic
Typically I just clone it into the home folder and delete it once I'm done.

    $   git clone https://github.com/rickellis/ArchMatic.git

---

### Run ArchMatic files
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

On subsequent logins use:

    $   startx


Congrats!

You should now have an Arch system running XFCE, with all the base packages that allow network connectivity, bluetooth, printers, etc., and a curated selection of applications.

### Additional Resources

I typically install the __[Arc Colora Themes](https://github.com/arcolinux/arcolinux-arc-themes)__. Just create a `.themes` folder in your home directory and place the Colora themes in there.
