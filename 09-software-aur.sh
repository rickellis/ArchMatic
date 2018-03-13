#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo
echo "INSTALLING AUR SOFTWARE"
echo

PKGS=(

    # SYSTEM UTILITIES ----------------------------------------------------

    'menulibre'             # Menu editor
    'gtkhash'               # Checksum verifier

    # TERMINAL UTILITIES --------------------------------------------------

    'hyper'                 # Terminal emulator built on Electron

    # UTILITIES -----------------------------------------------------------

    'dropbox'               # Cloud file storage
    'enpass-bin'            # Password manager

    # DEVELOPMENT ---------------------------------------------------------
    
    'visual-studio-code-bin'    # Kickass text editor

    # MEDIA ---------------------------------------------------------------

    'spotify'               # Music player
    'screenkey'             # Screencast your keypresses
    'aftershotpro3'         # Photo editor

    # POST PRODUCTION -----------------------------------------------------

    'peek'                  # GIF animation screen recorder

    # COMMUNICATIONS ------------------------------------------------------

    'skypeforlinux-stable-bin' # Skype

)


cd ${HOME}/CodeLab/AURIC
chmod +x auric.sh

for PKG in "${PKGS[@]}"; do
    ./auric.sh -i $PKG
done


echo
echo "Done!"
echo
echo "Now would be a good time to setup Dropbox and Enpass"
echo