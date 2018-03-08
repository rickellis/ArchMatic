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
#  Archomatic is an Arch Linux post-install setup and configuration script
#
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

# Array containing the installation files that will be executed by this script. 
# IMPORTANT: The order that the items appear in the array is the order in 
# which the execution happens.
INSTALL=( 
        xorg
        video-drivers
        display-manager
        desktop 
        network
        bluetooth
        audio
        printers
        sensors
        software-pacman
        extras 
        setup 
        personal
    )

# Name of the directory containing all the installer scripts
scriptdir="installers"

# This file is created automatically by Archomatic. As each installation 
# script is executed, the name is added to the tracker file. This allows
# Archomatic to be aborted, and the next time it's run it will pick up
# where it left off.
tracker="tracker.txt"


# Load colors.sh script to display pretty headings and colored text
# This is an optional (but recommended) dependency
BASEPATH=$(dirname "$0")
if [ -f "${BASEPATH}/colors.sh" ]; then
    . "${BASEPATH}/colors.sh"
else
    heading() {
        echo " ----------------------------------------------------------------------"
        echo "  $2"
        echo " ----------------------------------------------------------------------"
        echo
    }
fi

# MAIN HEADING ---------------------------------------------------------------------

clear
heading purple "Archomatic ${VERSION}"
read -p "Ready to begin? [y|n] " CONSENT
if ! [ -z "$CONSENT" ] && [ "$CONSENT" != 'y' ] && [ "$CONSENT" != 'Y' ]; then
    echo
    echo "Goodbye..."
    echo
    exit 1
fi

# PRE-FLIGHT CHECKS ----------------------------------------------------------------

clear
heading green "PRE-FLIGHT CHECKS"


if [ ! -e "${tracker}}" ] ; then
    touch "${tracker}"
fi

if [ ! -w "${tracker}" ] ; then
    echo -e ${red}!WRITABLE:${reset}  ${yellow}${tracker}${reset}
    PASS="n"
fi


PASS="y"
for filename in "${INSTALL[@]}"
do
    script="${scriptdir}/${filename}.sh"
    if [ ! -f "$script" ]; then
        echo -e "${red}FILE MISSING:${reset} ${yellow}${script}${reset}"
        PASS="n"
        continue
    else
        echo -e "${green}FILE EXISTS:${reset}  ${script}"
    fi

    if [ ! -x "$script" ]; then
        echo -e "${red}!EXECUTABLE:${reset}  ${yellow}${script}${reset}"
        PASS="n"
    fi
done

if [ "$PASS" == 'n' ]; then
    echo
    echo -e "${red}EXECUTION ABORTED:${reset} Pre-flight checks failed."
    echo
    exit 1
fi

echo
echo -e "${green}All pre-flight tests passed!${reset}"
echo

read -p "Ready to continue? [y|n] " CONSENT
if ! [ -z "$CONSENT" ] && [ "$CONSENT" != 'y' ] && [ "$CONSENT" != 'Y' ]; then
    echo
    echo "Goodbye..."
    echo
    exit 1
fi

# INSTALLATION ---------------------------------------------------------------------

clear
heading green "Install"

for filename in "${INSTALL[@]}"
do

    # if grep -Fxq "$filename" "$tracker"
    # then
    #     echo -e " ${ORG}SKIPPING${reset} ${filename}"
    #     continue
    # fi

    echo -ne "${green}INSTALL${reset} ${filename}? [y|n] "
    read DOIT

    if ! [ -z "$DOIT" ] && [ "$DOIT" != 'y' ] && [ "$DOIT" != 'Y' ]; then
        echo -e "${orange}SKIPPING${reset} ${filename}"
        continue
    fi

    . "${scriptdir}/${filename}.sh"


    # echo "${filename}" >> "${tracker}"

done

echo
echo
