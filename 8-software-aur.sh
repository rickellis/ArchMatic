#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _    
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__ 
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__| 
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "INSTALLING AUR SOFTWARE"
echo

cd "${HOME}"

echo "CLOING: YAY"
git clone "https://aur.archlinux.org/yay.git"


PKGS=(

    # SYSTEM UTILITIES ----------------------------------------------------

    'menulibre'                 # Menu editor
    'gtkhash'                   # Checksum verifier

    # TERMINAL UTILITIES --------------------------------------------------

    'hyper'                     # Terminal emulator built on Electron

    # UTILITIES -----------------------------------------------------------

    'dropbox'                   # Cloud file storage
    'lastpass'                  # Password manager
    'slimlock'                  # Screen locker
    'oomox'                     # Theme editor
    'samba'                     # Samba File Sharing
    'gnome-vfs'                 # Gnome File System Access
    'gvfs-smb'                  # More File System Stuff

    # DEVELOPMENT ---------------------------------------------------------
    
    'visual-studio-code-bin'    # Kickass text editor

    # MEDIA ---------------------------------------------------------------

    'screenkey'                 # Screencast your keypresses
    # 'aftershotpro3'             # Photo editor

    # POST PRODUCTION -----------------------------------------------------

    'peek'                      # GIF animation screen recorder

    # COMMUNICATIONS ------------------------------------------------------

    'google-chrome'             # Google Chrome
    

    # THEMES --------------------------------------------------------------

    'gtk-theme-arc-git'
    'adapta-gtk-theme-git'
    'paper-icon-theme'
    'tango-icon-theme'
    'tango-icon-theme-extras'
    'numix-icon-theme-git'
    'papirus-icon-theme' 
    'sardi-icons'
    'alacarte-xfce'
    'mugshot'
)


cd ${HOME}/yay
makepkg -si

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo
echo "Done!"
echo
