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


declare -a install=( xorg desktop display-manager aur-helpers network bluetooth audio video sound printers sensors software-pacman software-aur extras setup personal )

scriptdir="installers"

tracker="tracker.txt"

# TEXT COLORS ----------------------------------------------------------------------

RED="\033[91m" # Red
GRN="\033[92m" # Green
BLU="\033[94m" # Blue
YEL="\033[93m" # Yellow
ORG="\033[38;5;202m" # Orange
MAG="\033[95m" # Magenta
CYN="\033[96m" # Cyan
RST="\033[0m"  # Color Reset

# HEADING FUNCTION -----------------------------------------------------------------

# Generates heading with a background color and white text, centered.
function heading() {

    if [ -z "$1" ] || [ -z "$2" ]; then
        echo 'Usage: heading <color> "My cool heading"'
        exit 1
    fi

    color=${1}
    color=${color,,} # Lowercase the color
    text=${2}
    length=74 # Overal length of heading
    reset="\033[0m"
    
    case "$color" in
    black | blk)
        color="\033[40m\033[97m" # Black with white text
    ;;
    grey | gry)
        color="\033[47m\033[100m" # Grey with white text
    ;;
    red)
        color="\033[41m\033[97m" # Red with white text
    ;;
    darkred | dred)
        color="\033[48;5;52m\033[97m" # Dark red with white text
    ;;
    green | grn)
        color="\033[42m\033[97m" # Green with white text
    ;;
    blue | blu)
        color="\033[44m\033[97m" # Blue with white text
    ;;
    yellow | yel)
        color="\033[42m\033[97m" # Yellow with white text
    ;;
    orange | org)
        color="\033[48;5;202m\033[97m" # OrNGE with white text
    ;;
    olive | olv)
        color="\033[48;5;58m\033[97m" # Yellow with white text
    ;;
    magenta | mag)
        color="\033[45m\033[97m" # Magenta with white text
    ;;
    purple | pur)
        color="\033[48;5;53m" # Purple with white text
    ;;
    cyan | cyn)
        color="\033[46m\033[97m" # Cyan with white text
    ;;
    *)
        color="\033[45m\033[97m" # Magenta with white text
    ;;
    esac
    
    # Get the lenghth of text string
    # Divide 74 by the length.
    # Divide it in half.
    n=${#text}
    l=$(( length - n  )) 
    d=$(( l / 2 ))

    declare padding
    for i in $(seq 1 ${d}); do padding+=" "; done;

    echo
    echo -e "${color}${padding}${text}${padding}${reset}"
    echo
}

# CONSENT --------------------------------------------------------------------------

function consent() {
    unset CONSENT
    msg="Hit ENTER to continue:"

    if [ "$1" != "" ]; then
        msg=${1}
    fi

    echo
    read -p " ${msg} " CONSENT
    echo

    if ! [ -z "$CONSENT" ] && [ "$CONSENT" != 'y' ] && [ "$CONSENT" != 'Y' ]; then
        echo "Goodbye..."
        echo
        exit 1
    fi
}



# MAIN HEADING ---------------------------------------------------------------------

clear
heading purple "Archomatic ${VERSION}"
consent "Ready to begin? [y|n] "

# PRE-FLIGHT CHECKS ----------------------------------------------------------------

clear
heading green "PRE-FLIGHT CHECKS"


if [ ! -e "${tracker}}" ] ; then
    touch "${tracker}"
fi

if [ ! -w "${tracker}" ] ; then
    echo -e ${RED}!WRITABLE:${RST}  ${YEL}${tracker}${RST}
    PASS="n"
fi


PASS="y"
for filename in "${install[@]}"
do
    script="${scriptdir}/${filename}.sh"
    if [ ! -f "$script" ]; then
        echo -e " ${RED}FILE MISSING:${RST} ${YEL}${script}${RST}"
        PASS="n"
        continue
    else
        echo -e " ${GRN}FILE EXISTS:${RST}  ${script}"
    fi

    if [ ! -x "$script" ]; then
        echo -e " ${RED}!EXECUTABLE:${RST}  ${YEL}${script}${RST}"
        PASS="n"
    fi
done

if [ "$PASS" == 'n' ]; then
    echo
    echo -e " ${RED}EXECUTION ABORTED:${RST} Pre-flight checks failed."
    echo
    exit 1
fi

echo
echo -e " ${GRN}All pre-flight tests passed!${RST}"

consent "Ready to continue? [y|n] "


# INSTALLATION ---------------------------------------------------------------------

clear
heading green "Install"

for filename in "${install[@]}"
do

    if grep -Fxq "$filename" "$tracker"
    then
        echo -e " ${ORG}SKIPPING${RST} ${filename}"
        continue
    fi

    read -p " INSTALL ${filename}? [y|n] " DOIT

    if ! [ -z "$DOIT" ] && [ "$DOIT" != 'y' ] && [ "$DOIT" != 'Y' ]; then
        continue
    fi

    sh "${scriptdir}/${filename}.sh"

    echo "${filename}" >> "${tracker}"

done

echo
echo
