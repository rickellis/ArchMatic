#!/usr/bin/env bash
# Created by Liam Powell (gfelipe099)
# A compilation of all the files from ArchMatic's repository
# Made for ChrisTitusTech

#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

# Verify Arch Linux is running
if [ ! -f /usr/bin/pacman ]; then
    echo "Pacman Package Manager was not found in this system, execution aborted."
    exit
    else
        pacman -Sy && sudo pacman -Syyy && pacman -S lsb-release --noconfirm --needed &>/dev/null
        os=$(lsb_release -ds | sed 's/"//g')

if [ "${os}" != "Arch Linux" ]; then
    echo "You must be using Arch Linux to execute this script."
    exit 1
fi

function setup {
    if ! source install.conf; then
        read -p "Please enter hostname:" hostname

        read -p "Please enter username:" username

        read -ps "Please enter password:" password

        read -sp "Please repeat password:" password2

        # Check if both passwords match
        if [ "$password" != "$password2" ]; then
            echo "Passwords do not match"
            exit 1
        fi
    printf "hostname=$hostname\nusername=${username}\npassword=${password}" > "install.conf"
    fi

    echo "-------------------------------------------------"
    echo "Setting up mirrors for optimal download - US Only"
    echo "-------------------------------------------------"
    pacman -S --noconfirm pacman-contrib curl
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

    echo "-------------------------------------------------"
    echo "              makepkg configuration              "
    echo "-------------------------------------------------"
    nc=$(grep -c ^processor /proc/cpuinfo)
    echo "You have "$nc" cores."
    echo "-------------------------------------------------"
    echo "Changing the makeflags for "$nc" cores."
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$nc"/g' /etc/makepkg.conf
    echo "Changing the compression settings for "$nc" cores."
    sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T $nc -z -)/g' /etc/makepkg.conf

    echo "-------------------------------------------------"
    echo "       Setup Language to US and set locale       "
    echo "-------------------------------------------------"
    sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
    locale-gen
    timedatectl --no-ask-password set-timezone America/Chicago
    timedatectl --no-ask-password set-ntp 1
    localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_COLLATE="" LC_TIME="en_US.UTF-8"

    # Set keymaps
    localectl --no-ask-password set-keymap us

    # Hostname
    hostnamectl --no-ask-password set-hostname $hostname

    # Add sudo no password rights
    sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
}

function baseSetup {
    PKGS=(

        # --- XORG Display Rendering
            'xorg'                  # Base Package
            'xorg-drivers'          # Display Drivers 
            'xterm'                 # Terminal for TTY
            'xorg-server'           # XOrg server
            'xorg-apps'             # XOrg apps group
            'xorg-xinit'            # XOrg init
            'xorg-xinput'           # Xorg xinput
            'mesa'                  # Open source version of OpenGL

        # --- Setup Desktop
            'awesome'               # Awesome Desktop
            'xfce4-power-manager'   # Power Manager 
            'rofi'                  # Menu System
            'picom'                 # Translucent Windows
            'xclip'                 # System Clipboard
            'gnome-polkit'          # Elevate Applications
            'lxappearance'          # Set System Themes

        # --- Login Display Manager
            'lightdm'                   # Base Login Manager
            'lightdm-webkit2-greeter'   # Framework for Awesome Login Themes

        # --- Networking Setup
            'wpa_supplicant'            # Key negotiation for WPA wireless networks
            'dialog'                    # Enables shell scripts to trigger dialog boxes
            'openvpn'                   # Open VPN support
            'networkmanager-openvpn'    # Open VPN plugin for NM
            'network-manager-applet'    # System tray icon/utility for network connectivity
            'libsecret'                 # Library for storing passwords
        
        # --- Audio
            'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
            'alsa-plugins'      # ALSA plugins
            'pulseaudio'        # Pulse Audio sound components
            'pulseaudio-alsa'   # ALSA configuration for pulse audio
            'pavucontrol'       # Pulse Audio volume control
            'pnmixer'           # System tray volume control

        # --- Bluetooth
            'bluez'                 # Daemons for the bluetooth protocol stack
            'bluez-utils'           # Bluetooth development and debugging utilities
            'bluez-firmware'        # Firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips
            'blueberry'             # Bluetooth configuration tool
            'pulseaudio-bluetooth'  # Bluetooth support for PulseAudio
        
        # --- Printers
            'cups'                  # Open source printer drivers
            'cups-pdf'              # PDF support for cups
            'ghostscript'           # PostScript interpreter
            'gsfonts'               # Adobe Postscript replacement fonts
            'hplip'                 # HP Drivers
            'system-config-printer' # Printer setup  utility
    )

    for PKG in "${PKGS[@]}"; do
        sudo pacman -S "$PKG" --noconfirm --needed
    done
}

function softwareSetup {
    PACMANPKGS=(

        # SYSTEM --------------------------------------------------------------

        'linux-lts'             # Long term support kernel

        # TERMINAL UTILITIES --------------------------------------------------

        'bash-completion'       # Tab completion for Bash
        'bleachbit'             # File deletion utility
        'cronie'                # cron jobs
        'curl'                  # Remote content retrieval
        'file-roller'           # Archive utility
        'gtop'                  # System monitoring via terminal
        'gufw'                  # Firewall manager
        'hardinfo'              # Hardware info app
        'htop'                  # Process viewer
        'neofetch'              # Shows system info when you launch terminal
        'ntp'                   # Network Time Protocol to set time via network.
        'numlockx'              # Turns on numlock in X11
        'openssh'               # SSH connectivity tools
        'p7zip'                 # 7z compression program
        'rsync'                 # Remote file sync utility
        'speedtest-cli'         # Internet speed via terminal
        'terminus-font'         # Font package with some bigger fonts for login terminal
        'tlp'                   # Advanced laptop power management
        'unrar'                 # RAR compression program
        'unzip'                 # Zip compression program
        'wget'                  # Remote content retrieval
        'terminator'            # Terminal emulator
        'vim'                   # Terminal Editor
        'zenity'                # Display graphical dialog boxes via shell scripts
        'zip'                   # Zip compression program
        'zsh'                   # ZSH shell
        'zsh-completions'       # Tab completion for ZSH

        # DISK UTILITIES ------------------------------------------------------

        'android-tools'         # ADB for Android
        'android-file-transfer' # Android File Transfer
        'autofs'                # Auto-mounter
        'btrfs-progs'           # BTRFS Support
        'dosfstools'            # DOS Support
        'exfat-utils'           # Mount exFat drives
        'gparted'               # Disk utility
        'gvfs-mtp'              # Read MTP Connected Systems
        'gvfs-smb'              # More File System Stuff
        'nautilus-share'        # File Sharing in Nautilus
        'ntfs-3g'               # Open source implementation of NTFS file system
        'parted'                # Disk utility
        'samba'                 # Samba File Sharing
        'smartmontools'         # Disk Monitoring
        'smbclient'             # SMB Connection 
        'xfsprogs'              # XFS Support

        # GENERAL UTILITIES ---------------------------------------------------

        'flameshot'             # Screenshots
        'freerdp'               # RDP Connections
        'libvncserver'          # VNC Connections
        'nautilus'              # Filesystem browser
        'remmina'               # Remote Connection
        'veracrypt'             # Disc encryption utility
        'variety'               # Wallpaper changer

        # DEVELOPMENT ---------------------------------------------------------

        'gedit'                 # Text editor
        'clang'                 # C Lang compiler
        'cmake'                 # Cross-platform open-source make system
        'code'                  # Visual Studio Code
        'electron'              # Cross-platform development using Javascript
        'git'                   # Version control system
        'gcc'                   # C/C++ compiler
        'glibc'                 # C libraries
        'meld'                  # File/directory comparison
        'nodejs'                # Javascript runtime environment
        'npm'                   # Node package manager
        'python'                # Scripting language
        'yarn'                  # Dependency management (Hyper needs this)

        # MEDIA ---------------------------------------------------------------

        'kdenlive'              # Movie Render
        'obs-studio'            # Record your screen
        'celluloid'             # Video player
        
        # GRAPHICS AND DESIGN -------------------------------------------------

        'gcolor2'               # Colorpicker
        'gimp'                  # GNU Image Manipulation Program
        'ristretto'             # Multi image viewer

        # PRODUCTIVITY --------------------------------------------------------

        'hunspell'              # Spellcheck libraries
        'hunspell-en'           # English spellcheck library
        'xpdf'                  # PDF viewer

    )

    AURPKGS=(

    # UTILITIES -----------------------------------------------------------

    'i3lock-fancy'              # Screen locker
    'synology-drive'            # Synology Drive
    'freeoffice'                # Office Alternative
    
    # MEDIA ---------------------------------------------------------------

    'screenkey'                 # Screencast your keypresses
    'lbry-app-bin'              # LBRY Linux Application

    # COMMUNICATIONS ------------------------------------------------------

    'brave-nightly-bin'         # Brave
    

    # THEMES --------------------------------------------------------------

    'lightdm-webkit-theme-aether'   # Lightdm Login Theme - https://github.com/NoiSek/Aether#installation
    'materia-gtk-theme'             # Desktop Theme
    'papirus-icon-theme'            # Desktop Icons
    )

    for PAC in "${PACMANPKGS[@]}"; do
        sudo pacman -S "$PAC" --noconfirm --needed
    done

    # Clone yay repository and install it
    cd ${HOME} && git clone "https://aur.archlinux.org/yay.git" && cd ${HOME}/yay && makepkg -si

    for AUR in "${AURPKGS[@]}"; do
        sudo pacman -S "$AUR" --noconfirm --needed
    done
}

function postInstallation {
    # Generate the .xinitrc file so we can launch Awesome from the
    # terminal using the "startx" command
    printf '#!/bin/bash
# Disable bell
xset -b

# Disable all Power Saving Stuff
xset -dpms
xset s off

# X Root window color
xsetroot -solid darkgrey

# Merge resources (optional)
#xrdb -merge $HOME/.Xresources

# Caps to Ctrl, no caps
setxkbmap -layout us -option ctrl:nocaps
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "\$f" ] && . "\$f"
    done
unset f
fi' > ${HOME}/.xinitrc

    # ------------------------------------------------------------------------

    echo
    echo "Updating /bin/startx to use the correct path"

    # By default, startx incorrectly looks for the .serverauth file in our HOME folder.
    sudo sed -i 's|xserverauthfile=\$HOME/.serverauth.\$\$|xserverauthfile=\$XAUTHORITY|g' /bin/startx

    # ------------------------------------------------------------------------

    echo
    echo "Configuring LTS Kernel as a secondary boot option"

    sudo cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf
    sudo sed -i 's|Arch Linux|Arch Linux LTS Kernel|g' /boot/loader/entries/arch-lts.conf
    sudo sed -i 's|vmlinuz-linux|vmlinuz-linux-lts|g' /boot/loader/entries/arch-lts.conf
    sudo sed -i 's|initramfs-linux.img|initramfs-linux-lts.img|g' /boot/loader/entries/arch-lts.conf

    # ------------------------------------------------------------------------

    echo
    echo "Configuring vconsole.conf to set a larger font for login shell"

    printf 'KEYMAP=us
FONT=ter-v32b' < /etc/vconsole.conf

    # ------------------------------------------------------------------------

    echo
    echo "Disabling buggy cursor inheritance"

    # When you boot with multiple monitors the cursor can look huge. This fixes it.
    printf '[Icon Theme]
#Inherits=Theme' > /usr/share/icons/default/index.theme

    # ------------------------------------------------------------------------

    echo
    echo "Increasing file watcher count"

    # This prevents a "too many files" error in Visual Studio Code
    echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system

    # ------------------------------------------------------------------------

    echo
    echo "Disabling Pulse .esd_auth module"

    # Pulse audio loads the `esound-protocol` module, which best I can tell is rarely needed.
    # That module creates a file called `.esd_auth` in the home directory which I'd prefer to not be there. So...
    sudo sed -i 's|load-module module-esound-protocol-unix|#load-module module-esound-protocol-unix|g' /etc/pulse/default.pa

    # ------------------------------------------------------------------------

    echo
    echo "Enabling Login Display Manager"

    sudo systemctl enable --now lightdm.service

    # ------------------------------------------------------------------------

    echo
    echo "Enabling bluetooth daemon and setting it to auto-start"

    sudo sed -i 's|#AutoEnable=false|AutoEnable=true|g' /etc/bluetooth/main.conf
    sudo systemctl enable --now bluetooth.service

    # ------------------------------------------------------------------------

    echo
    echo "Enabling the cups service daemon so we can print"

    systemctl enable --now org.cups.cupsd.service

    echo "Configuring NTP, DHCP and NetworkManager services"
    sudo ntpd -qg && sudo systemctl enable --now ntpd && sudo systemctl disable dhcpcd && sudo systemctl stop dhcpcd && sudo systemctl enable --now NetworkManager

    # Remove no password sudo rights
    sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
    # Add sudo rights
    sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

    # Clean orphans pkg
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        pacman -Rns $(pacman -Qdtq)
    fi

    # Replace in the same state
    cd $pwd
}
clear
echo -n "\nStarting setup ... "
sleep 5
clear
setup
echo -n "\nStarting base setup ... "
sleep 5
clear
baseSetup
echo -n "\nStarting software setup ... "
sleep 5
clear
softwareSetup
echo -n "\nStarting post installation setup ... "
sleep 5
clear
postInstallation
clear
echo -n "\n\n\nArchMatic finished the installation and configuration of the system!\n\n\n"
