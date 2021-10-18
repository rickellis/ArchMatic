#!/bin/bash

mkdir -p $HOME/ArchMatic/KDErice/.kde4/share/config
mkdir -p $HOME/ArchMatic/KDErice/.local/share/dolphin
mkdir -p $HOME/ArchMatic/KDErice/.local/share/plasma
cp -r $HOME/.config $HOME/ArchMatic/KDErice/.config
cp -r /etc/sddm.conf.d $HOME/ArchMatic/KDErice/sddm.conf.d
cp -r $HOME/.kde4/share/config/ $HOME/ArchMatic/KDErice/.kde4/share/config
cp -r $HOME/.local/share/dolphin $HOME/ArchMatic/KDErice/.local/share/dolphin
cp -r $HOME/.local/share/plasma $HOME/ArchMatic/KDErice/.local/share/plasma