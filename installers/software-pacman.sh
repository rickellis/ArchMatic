#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Software via Pacman
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

echo -e "${yellow}INSTALLING${reset} Software via Pacman"

PKGS=(

    # TERMINAL UTILITIES ------------------------------------------------

    'bash-completion'       # Tab completion for Bash
    'bc'                    # Precision calculator language
    'bleachbit'             # File deletion utility
    'curl'                  # Remote content retrieval
    'feh'                   # Terminal-based image viewer/manipulator
    'file-roller'           # Archive utility
    'gnome-keyring'         # System password storage
    'gtop'                  # System monitoring via terminal
    'gufw'                  # Firewall manager
    'hardinfo'              # Hardware info app
    'htop'                  # Process viewer
    'inxi'                  # System information utility
    'jq'                    # JSON parsing library
    'jshon'                 # JSON parsing library
    'neofetch'              # System info with terminal launch
    'numlockx'              # Turns on numlock in X11
    'rsync'                 # Remote file sync utility
    'speedtest-cli'         # Internet speed via terminal
    'tlp'                   # Advanced laptop power management
    'unrar'                 # RAR compression program
    'unzip'                 # Zip compression program
    'volumeicon'            # Volume control for system tray
    'wget'                  # Remote content retrieval
    'xfce4-terminal'        # Terminal emulator
    'zenity'                # Display graphical dialog boxes via shell scripts
    'zip'                   # Zip compression program
    'zsh'                   # ZSH shell
    'zsh-completions'       # Tab completion for ZSH

    # DISK UTILITIES ---------------------------------------------------------------

    'autofs'                # Auto-mounter
    'exfat-utils'           # Mount exFat drives
    'gparted'               # Disk utility
    'gnome-disks'           # Disk utility
    'ntfs-3g'               # Open source implementation of NTFS file system 
    'parted'                # Disk utility


    # UTILITIES --------------------------------------------------------------------

    'catfish'               # Filesystem search
    'conky'                 # System information viewer
    'nemo'                  # Filesystem browser
    'veracrypt'             # Disc encryption utility
    'variety'               # Wallpaper changer
    'xfburn'                # CD burning application

    # DEVELOPMENT ------------------------------------------------------------------

    'apache'                # Apache web server
    'electron'              # Cross-platform development using Javascript
    'git'                   # Version control system
    'gcc'                   # C/C++ compiler
    'glibc'                 # C libraries
    'mariadb'               # Drop-in replacement for MySQL
    'meld'                  # File/directory comparison
    'nodejs'                # Javascript runtime environment
    'npm'                   # Node package manager
    'php'                   # Web application scripting language
    'postfix'               # SMTP agent
    'python'                # Scripting language
    'yarn'                  # Dependency management (Hyper needs this)

    # WEB TOOLS --------------------------------------------------------------------

    'chromium'              # Web browser
    'firefox'               # Web browser
    'filezilla'             # FTP Client
    'flashplugin'           # Flash

    # COMMUNICATIONS ---------------------------------------------------------------

    'hexchat'               # Multi format chat
    'irssi'                 # Terminal based IIRC

    # MEDIA ------------------------------------------------------------------------

    'lollypop'              # Music player
    'simplescreenrecorder'  # Record your screen
    'vlc'                   # Video player
    'xfce4-screenshooter'   # Screen capture. Does this get installed with XFCE?

    # GRAPHICS AND DESIGN ----------------------------------------------------------

    'gcolor2'               # Colorpicker
    'gimp'                  # GNU Image Manipulation Program
    'inkscape'              # Vector image creation app
    'imagemagick'           # Command line image manipulation tool
    'nomacs'                # Image viewer
    'ristretto'             # Multi image viewer

    # PRODUCTIVITY -----------------------------------------------------------------

    'galculator'            # Gnome calculator
    'evince'                # Multi format document viewer !!INVESTIGATE
    'hunspell'              # Spellcheck libraries
    'hunspell-en'
    'libreoffice-fresh'     # Libre office with extra features
    'mousepad'              # XFCE simple text editor

    # VIRTUALIZATION ---------------------------------------------------------------

    'virtualbox'
    'virtualbox-guest-utils'
    'virtualbox-host-modules-arch'
)



for pk in "${PKGS[@]}"
do
    echo " $pk"
done
