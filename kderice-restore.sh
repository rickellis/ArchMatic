#!/bin/bash

cp -r $HOME/ArchMatic/KDErice/.config $HOME/.config/
sudo cp -r /etc/sddm.conf.d/ $HOME/ArchMatic/KDErice/sddm.conf.d
mkdir -p $HOME/.kde4/share/config/
mkdir -p $HOME/.local/share/dolphin
mkdir -p $HOME/.local/share/plasma
cp -r $HOME/ArchMatic/KDErice/.kde4/share/config $HOME/.kde4/share/config/
cp -r $HOME/ArchMatic/KDErice/.local/share/dolphin $HOME/.local/share/dolphin
cp -r $HOME/ArchMatic/KDErice/.local/share/plasma $HOME/.local/share/plasma