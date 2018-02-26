#!/usr/bin/env bash
#
#-----------------------------------------------------------------------------------
#
#  Printer Drivers
#
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------
#

PRINTPKGS=(

    # PRINTER DRIVERS -----------------------------------------------

    'cups'              # Open source printer drivers
    'cups-pdf'          # PDF support for cups

    'ghostscript'       # PostScript interpreter

    'cups-filters'      # !! INVESTIGATE
    'hplip'             # HP Util. !!INVESTIGATE
    'gutenprint'        # Print drivers !!INVESTIGATE

)


systemctl enable org.cups.cupsd.service

echo " INSTALLING Printer Drivers"
