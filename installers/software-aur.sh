#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  AUR Software
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

echo -e "${yellow}INSTALLING${reset} AUR Software"



AURPKGS=(

    # SYSTEM UTILITIES ----------------------------------------------

    'menulibre'             # Menu editor
    'gtkhash'               # Checksum verifier

    # TERMINAL UTILITIES --------------------------------------------

    'hyper'                 # Terminal emulator built on Electron

    # UTILITIES -----------------------------------------------------

    'dropbox'               # Cloud file storage
    'enpass-bin'            # Password manager

    # DEVELOPMENT ---------------------------------------------------
    
    'visual-studio-code-bin'    # Kickass text editor

    # MEDIA ---------------------------------------------------------

    'spotify'               # Music player
    'screenkey'             # Screencast your keypresses

    # POST PRODUCTION -----------------------------------------------

    'peek'                  # GIF animation screen recorder

    # COMMUNICATIONS ------------------------------------------------

    'skypeforlinux-stable-bin' # Skype

)


for pk in "${AURPKGS[@]}"
do
    echo " $pk"
done