#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#-------------------------------------------------------------------------

echo "INSTALLING PRINTER DRIVERS"

PKGS=(

    'cups'              # Open source printer drivers
    'cups-pdf'          # PDF support for cups
    'ghostscript'       # PostScript interpreter
    'cups-filters'      # !! INVESTIGATE
    'hplip'             # HP Util. !!INVESTIGATE
    'gutenprint'        # Print drivers !!INVESTIGATE
)

for PKG in "${PKGS[@]}"; do

    echo "INSTALLING ${PKG}"

    # sudo pacman -S "$PKG" --noconfirm --needed

done

# systemctl enable org.cups.cupsd.service