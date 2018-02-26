#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Audio Components
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------

AUDIOPKGS=(
            'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components
            'alsa-plugins'      # MORE INFO: https://alsa.opensrc.org/
            'pulseaudio'        # Pulse Audio sound components
            'pulseaudio-alsa'   # ALSA configuration for pulse audio
            'pavucontrol'       # Pulse Audio volume control
            'volumeicon'        # System tray volume control
)

echo " INSTALLING Audio Components"

 for pk in "${AUDIOPKGS[@]}"
do
    echo $pk
done
