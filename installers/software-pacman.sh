#!/usr/bin/env bash
#
#-----------------------------------------------------------------------------------
#
#  Software via Pacman
#
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------
#

echo " INSTALLING Pacman Software"


PKGS=(

    # SYSTEM UTILITIES ----------------------------------------------

    'gnome-keyring'     # System password storage
    'gtop'              # System monitoring via terminal
    'gufw'              # Firewall manager
    'hardinfo'          # Hardware info app
    'htop'              # Process viewer
    'inxi'              # System information utility
    'numlockx'          # Turns on numlock in X11
    'file-roller'       # Archive utility
    'unrar'             # RAR compression program
    'zip'               # Zip compression program
    'unzip'             # Zip compression program
    'tlp'               # Advanced laptop power management
    'bleachbit'         # File deletion utility
    'volumeicon'        # Volume control for system tray
    'zenity'            # Display graphical dialog boxes via shell scripts

    # DISK UTILITIES -----------------------------------------------

    'parted'            # Disk utility
    'gparted'           # Disk utility
    'gnome-disks'       # Disk utility
    'exfat-utils'       # Mount exFat drives
    'ntfs-3g'           # Open source implementation of NTFS file system 
    'autofs'            # Auto-mounter
    
    # TERMINAL UTILITIES --------------------------------------------

    'xfce4-terminal'    # Terminal emulator
    'bash-completion'   # Tab completion for Bash
    'neofetch'          # System info with terminal launch
    'bc'                # Precision calculator language
    'jq'                # JSON parsing library
    'jshon'             # JSON parsing library
    'wget'              # Remote content retrieval
    'curl'              # Remote content retrieval
    'rsync'             # Remote file sync utility
    'zsh'               # ZSH shell
    'zsh-completions'   # Tab completion for ZSH
    'speedtest-cli'     # Internet speed via terminal

    # UTILITIES -----------------------------------------------------

    'nemo'              # Filesystem browser
    'conky'             # System information viewer
    'catfish'           # Filesystem search
    'veracrypt'         # Disc encryption utility
    'variety'           # Wallpaper changer
    'xfburn'            # CD burning application

    # DEVELOPMENT ---------------------------------------------------

    'git'               # Version control system
    'python'            # Scripting language
    'electron'          # Cross-platform development using Javascript
    'nodejs'            # Javascript runtime environment
    'apache'            # Apache web server
    'php'               # Web application scripting language
    'mariadb'           # Drop-in replacement for MySQL
    'gcc'               # C/C++ compiler
    'glibc'             # C libraries
    'postfix'           # SMTP agent
    'meld'              # File/directory comparison

    # WEB TOOLS -----------------------------------------------------

    'firefox'           # Web browser
    'chromium'          # Web browser
    'filezilla'         # FTP Client
    'flashplugin'       # Flash

    # COMMUNICATIONS ------------------------------------------------

    'hexchat'           # Multi format chat
    'irssi'             # Terminal based IIRC

    # MEDIA ---------------------------------------------------------

    'vlc'               # Video player
    'lollypop'          # Music player
    'simplescreenrecorder' # Record your screen
    # 'xfce4-screenshooter' # Screen capture. Does this get installed with XFCE?

    # GRAPHICS AND DESIGN -------------------------------------------

    'gimp'              # GNU Image Manipulation Program
    'inkscape'          # Vector image creation app
    'imagemagick'       # Command line image manipulation tool
    'gcolor2'           # Colorpicker
    'ristretto'         # Multi image viewer
    'nomacs'            # Image viewer

    # PRODUCTIVITY --------------------------------------------------

    'libreoffice-fresh' # Libre office with extra features
    'mousepad'          # XFCE simple text editor
    'galculator'        # Gnome calculator
    'evince'            # Multi format document viewer !!INVESTIGATE
    'hunspell'          # Spellcheck libraries
    'hunspell-en'

    # VIRTUALIZATION ------------------------------------------------

    'virtualbox'
    'virtualbox-guest-utils'
    'virtualbox-host-modules-arch'
)



for pk in "${PKGS[@]}"
do
    echo $pk
done


