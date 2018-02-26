#!/usr/bin/env bash
#-----------------------------------------------------------------------------------
#  Xorg
#-----------------------------------------------------------------------------------
# Author:   Rick Ellis
# URL:      https://github.com/rickellis/archomatic
# License:  MIT
#-----------------------------------------------------------------------------------


# NOTE: At some point it will likely make sense to use Wayland instead of Xorg


XPKGS=(
        'xorg-server'           # XOrg server
        'xorg-apps'             # XOrg apps group
        'xorg-server-xwayland'  # 
        'xorg-xinit'            # XOrg init
        'xf86-video-intel'      # 2D/3D video driver
        'mesa'                  # Open source version of OpenGL
)


echo " INSTALLING Xorg"
