#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#
#    /_\  _ _ __| |_  ___ _ __  __ _| |_(_)__ 
#   / _ \| '_/ _| ' \/ _ \ '  \/ _` |  _| / _|
#  /_/ \_\_| \__|_||_\___/_|_|_\__,_|\__|_\__|
#   Automated Arch Linux Installation Script
#
#-----------------------------------------------------------------------------------
VERSION="1.0.0"
#-----------------------------------------------------------------------------------
#
#  Archomatic does the following:
#
#    * Creates a 16 color palette image from the current wallpaper.
#    * Extracts the hex color values of the palette.
#    * Generates a .conkyrc file using colors randomly selected from the palette.
#    * Exports a set of colorized weather icons.
#    * Copies the new .conkyrc file to the home folder.
#    * Relaunches the Conky application.
#
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------






# TEXT COLORS ----------------------------------------------------------------------

DFT="\033[39m" # Terminal default color
BLK="\033[30m" # Black
GRY="\033[37m" # Grey
RED="\033[91m" # Red
GRN="\033[92m" # Green
BLU="\033[94m" # Blue
YEL="\033[93m" # Yellow
MAG="\033[95m" # Magenta
CYN="\033[96m" # Cyan
WHT="\033[97m" # White

# BACKGROUND COLORS ----------------------------------------------------------------

BDFT="\033[49m" # Terminal default color
BBLK="\033[40m" # Black
BGRY="\033[47m" # Grey
BRED="\033[41m" # Red
BGRN="\033[42m" # Green
BBLU="\033[44m" # Blue
BYEL="\033[42m" # Yellow
BMAG="\033[45m" # Magenta
BCYN="\033[46m" # Cyan
BWHT="\033[107m" # White

# COLOR RESET ----------------------------------------------------------------------

RST="\033[0m"


# HEADING --------------------------------------------------------------------------

clear
echo
echo -e "${BMAG}                    Archomatic VERSION ${VERSION}                         ${RST}"
echo
echo

read -p " Hit ENTER to begin, or any other key to abort: " CONSENT

if ! [ -z "$CONSENT" ]; then
    echo
    echo "Goodbye..."
    echo
    exit 1
fi








echo " hello"
echo
