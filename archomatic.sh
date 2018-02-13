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



echo ""
echo "-----------------------------------------------------------------------"
echo " Welcome to Archomatic Version ${VERSION}"
echo "-----------------------------------------------------------------------"
echo ""



