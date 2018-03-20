# Arch Linux Post Installation Setup and Config Scripts

<img src="https://i.imgur.com/uFysgdN.png" />

This README contains the steps I do to install and configure a fully-functional Arch Linux installation containing a desktop environment, all the support packages (network, bluetooth, audio, printers, etc.), along with all my preferred applications and utilities. This document assumes that a base __[Arch Linux Installation](https://github.com/rickellis/Arch-Linux-Install-Guide)__ has been completed.

The shell scripts in this repo allow the entire process to be automated. I also run some scripts that copy over my personal files, my git repos, and my dotfiles so all my settings and preferences get set by default Those are not available publicly since they would provide little use to anyone else

Setting up an Arch system from scratch is usually a time-intensive process. My goal in developing these scripts and my __[installation guide](https://github.com/rickellis/Arch-Linux-Install-Guide)__ was to be able to go from a blank hard drive to a fully functional Arch system with all my files, applications, and preferences set, as efficiently as possible. Typically a complete install takes me between two and three hours. Much of that time is just waiting for all the files to download, and invoking each script as needed.

Lastly, some of the configuration steps are specific to the laptop I'm currently running, a Dell XPS 13. So...

### Don't just run these scripts. Examine them. Customize them to suit your needs.

---

### System Description
I run XFCE desktop since it's fast and lightweight. I don't install a greeter, preferring to always boot into the terminal by default. That way if there is ever a show-stopping problem with Xorg or XFCE I can fix it without having to boot from an external drive. To launch XFCE I enter `startx` in the terminal.

I also install the LTS Kernel along side the rolling one, and configure my bootloader to offer both as a choice during startup. This enables me to switch kernels in the event of a problem with the rolling one.

I set up my machines as development environments since that mostly what I do. To that end I install lots of dev tools and customize various things to increase productivity. For exmple, I set up Apache server to run as me, with the WebServer directory located in my home folder.

I run my own utilites: __[WifiVPN](https://github.com/rickellis/WifiVPN)__ for network connectivity, and __[AURIC](https://github.com/rickellis/AURIC)__ for AUR package management.

Since I use Mac as well, I mirror as much as possible on both systems via git and Dropbox, so I can switch back and forth with no interruption in productivity.

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

You should now have an Arch system running XFCE.

### Additional Resources

I typically install the __[Arc Colora Themes](https://github.com/arcolinux/arcolinux-arc-themes)__. Just create a `.themes` folder in your home directory and place them in there.
