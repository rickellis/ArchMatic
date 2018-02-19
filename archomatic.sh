#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#
#    /_\  _ _ __| |_  ___ _ __  __ _| |_(_)__ 
#   / _ \| '_/ _| ' \/ _ \ '  \/ _` |  _| / _|
#  /_/ \_\_| \__|_||_\___/_|_|_\__,_|\__|_\__|
#   Automated Arch Linux Installation Script
#
#-----------------------------------------------------------------------------------
APPNAME="Archomatic"
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

compdir="components"

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

BDFT="\033[49m\033[97m" # Terminal default color
BBLK="\033[40m\033[97m" # Black
BGRY="\033[47m\033[97m" # Grey
BRED="\033[41m\033[97m" # Red
BGRN="\033[42m\033[97m" # Green
BBLU="\033[44m\033[97m" # Blue
BYEL="\033[42m\033[97m" # Yellow
BMAG="\033[45m\033[97m" # Magenta
BCYN="\033[46m\033[97m" # Cyan
BWHT="\033[107m\033[97m" # White

# COLOR RESET ----------------------------------------------------------------------




# HEADING --------------------------------------------------------------------------

function heading() {

    if [ -z $1 ]; then
        color="MAG"
    else
        color=${1}
    fi

    # Uppercase the color
    color=${color^^}
    case "$SELECTION" in
    BLACK)
        color="\033[40m\033[97m" # Black
    ;;
    GREY)
        color="\033[47m\033[97m" # Grey
    ;;
    RED)
        color="\033[41m\033[97m" # Red
    ;;
    GREEN)
        color="\033[42m\033[97m" # Green
    ;;
    BLUE)
        color="\033[44m\033[97m" # Blue
    ;;
    YELLOW)
        color="\033[42m\033[97m" # Yellow
    ;;
    MAGENTA)
        color="\033[45m\033[97m" # Magenta
    ;;
    CYAN)
        color="\033[46m\033[97m" # Cyan
    ;;padding
    *)
        color="\033[45m\033[97m" # Magenta
    ;;
    esac
    reset="\033[0m"

    # Set the default text if no argument is passed
    if [ -z "${2}" ]; then
        text="${APPNAME} ${VERSION}"
    else
        text=${2}
    fi

    # Get the lenghth of the string that was passed
    # Divide 74 by the length.
    # Divide it in half.
    n=${#text}
    l=$(( 74 - n  )) 
    d=$(( l / 2 ))

    pad=""
    for i in $(seq 1 ${d});
    do 
        pad+=" "
    done

    echo
    echo -e "${color}${pad}${text}${pad}${reset}"
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

    if ! [ -z "$CONSENT" ]; then
        echo "Goodbye..."
        echo
        exit 1
    fi
}








heading


exit 1
consent "Hit ENTER to begin, or any other key to abort"







echo -e "${BGRN}                         PRE-FLIGHT CHECKS                           ${RST}"
echo


PASS="y"
for filename in "${install[@]}"
do
    script="${compdir}/${filename}.sh"
    if [ ! -f "$script" ]; then
        echo -e " ${RED}FILE MISSING: ${script}${RST}"
        PASS="n"
    else
        echo -e " ${GRN}FILE EXISTS:  ${script}${RST}"
    fi
    if [ ! -x "$script" ]; then
        echo -e " ${RED}! EXECUTABLE: ${script}${RST}"
        PASS="n"
    fi
done



if [ "$PASS" == 'n' ]; then
    echo
    echo -e " ${RED}EXECUTION ABORTED: Pre-flight checks failed.${RST}"
    echo
    exit 1
fi

consent "All pre-flight tests passed! Hit ENTER to continue"


heading
for filename in "${install[@]}"
do
    script="${compdir}/${filename}.sh"

    if [ ! -f "$script" ]; then
        echo " ERROR; Unable to find: ${script}"
        break
    fi

    sh "${compdir}/${filename}.sh"

done


echo