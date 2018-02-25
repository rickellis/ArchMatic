#!/usr/bin/env bash
#
#-----------------------------------------------------------------------------------
#
#  AUR Software
#
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------
#

echo " INSTALLING AUR Software"


AURPKGS=(

    # SYSTEM UTILITIES ----------------------------------------------

    'menulibre'             # Menu editor
    'gtkhash'               # Checksum verifier

    # TERMINAL UTILITIES --------------------------------------------

    'oh-my-zsh-git'         # ZSH library

    # UTILITIES -----------------------------------------------------

    'dropbox'               # Cloud file storage
    'enpass-bin'            # Password manager

    # DEVELOPMENT ---------------------------------------------------
    
    'visual-studio-code-bin'    # Kickass text editors
    # 'visual-studio-code-insiders' # Insiders version

    # MEDIA ---------------------------------------------------------

    'spotify'               # Music player
    'screenkey'             # Screencast your keypresses

    # POST PRODUCTION -----------------------------------------------

    'davinci-resolve'       # Post prodution suite
    'peek'                  # GIF animation screen recorder

    # COMMUNICATIONS ------------------------------------------------

    'skypeforlinux-bin'     # Skype

)
