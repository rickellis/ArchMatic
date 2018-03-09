#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#--------------------------------------------------------------------------

echo "INSTALLING AUR SOFTWARE"

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

    # POST PRODUCTION -----------------------------------------------------

    'peek'                  # GIF animation screen recorder

    # COMMUNICATIONS ------------------------------------------------------

    'skypeforlinux-stable-bin' # Skype
)


cd ${HOME}/CodeLab/AURIC
chmod +x auric.sh

for PKG in "${PKGS[@]}"; do
    ./auric.sh $PKG
done