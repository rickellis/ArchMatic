#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#-------------------------------------------------------------------------

echo
echo "INSTALLING PRINTER DRIVERS"
echo

PKGS=(
    'cups'                  # Open source printer drivers
    'cups-pdf'              # PDF support for cups
    'ghostscript'           # PostScript interpreter
    'gsfonts'               # Adobe Postscript replacement fonts
    'hplip'                 # HP Drivers
    'system-config-printer' # Printer setup  utility
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Enabling systemctl cups.service"
echo

systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service

echo
echo "Done!"
echo
