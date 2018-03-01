#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Printer Drivers
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------


echo -e "${yellow}INSTALLING${reset} Printer Drivers"

PRINTPKGS=(

    # PRINTER DRIVERS -----------------------------------------------

    'cups'              # Open source printer drivers
    'cups-pdf'          # PDF support for cups

    'ghostscript'       # PostScript interpreter

    'cups-filters'      # !! INVESTIGATE
    'hplip'             # HP Util. !!INVESTIGATE
    'gutenprint'        # Print drivers !!INVESTIGATE

)


# systemctl enable org.cups.cupsd.service

for pk in "${PRINTPKGS[@]}"
do
    echo " $pk"
done
