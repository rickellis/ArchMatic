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
#  Archomatic is an Arch Linux installation script
#
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

# Array containing the files that will be executed by this script. 
# IMPORTANT: The order that the items appear in the array is the
# order in which the execution happens.
declare -a install=( xorg desktop display-manager aur-helpers network bluetooth audio video sound printers sensors software-pacman software-aur extras setup personal )

# Name of the directory containing all the installer scripts
scriptdir="installers"

# This file is created automatically by Archomatic. As each installation 
# script is executed, the name is added to the tracker file. This allows
# Archomatic to be aborted, and the next time it's run it will pick up
# where it left off.
tracker="tracker.txt"


# Source the functions script
. functions.sh


# MAIN HEADING ---------------------------------------------------------------------

clear
sheading purple "Archomatic ${VERSION}"
read -p "Ready to begin? [y|n] " CONSENT
if ! [ -z "$CONSENT" ] && [ "$CONSENT" != 'y' ] && [ "$CONSENT" != 'Y' ]; then
    echo
    echo "Goodbye..."
    echo
    exit 1
fi

# PRE-FLIGHT CHECKS ----------------------------------------------------------------

clear
sheading green "PRE-FLIGHT CHECKS"


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
        echo -e "${RED}FILE MISSING:${RST} ${YEL}${script}${RST}"
        PASS="n"
        continue
    else
        echo -e "${GRN}FILE EXISTS:${RST}  ${script}"
    fi

    if [ ! -x "$script" ]; then
        echo -e "${RED}!EXECUTABLE:${RST}  ${YEL}${script}${RST}"
        PASS="n"
    fi
done

if [ "$PASS" == 'n' ]; then
    echo
    echo -e "${RED}EXECUTION ABORTED:${RST} Pre-flight checks failed."
    echo
    exit 1
fi

echo
echo -e "${GRN}All pre-flight tests passed!${RST}"
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
sheading green "Install"

for filename in "${install[@]}"
do

    if grep -Fxq "$filename" "$tracker"
    then
        echo -e " ${ORG}SKIPPING${RST} ${filename}"
        continue
    fi

    echo -ne " ${GRN}INSTALL${RST} ${filename}? [y|n] "
    read DOIT

    if ! [ -z "$DOIT" ] && [ "$DOIT" != 'y' ] && [ "$DOIT" != 'Y' ]; then
        continue
    fi

    sh "${scriptdir}/${filename}.sh"
    echo "${filename}" >> "${tracker}"

done

echo
echo
