#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Audio Components
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

echo -e "${yellow}INSTALLING${reset} Audio Components"

AUDIOPKGS=(
            'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
            'alsa-plugins'      # ALSA plugins
            'pulseaudio'        # Pulse Audio sound components
            'pulseaudio-alsa'   # ALSA configuration for pulse audio
            'pavucontrol'       # Pulse Audio volume control
            'volumeicon'        # System tray volume control
)


 for pkg in "${AUDIOPKGS[@]}"
do
    # sudo pacman -S "$pkg" --noconfirm --needed

    echo " $pkg"
done
