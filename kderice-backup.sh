#!/bin/bash

cp -r $HOME/.config/ $HOME/ArchMatic/KDErice/.config
sudo cp -r /etc/sddm.conf.d/ $HOME/ArchMatic/KDErice/sddm.conf.d
mkdir -p .kde4/share/config
mkdir -p .local/share/dolphin
mkdir -p .local/share/plasma
cp -r $HOME/.kde4/share/config/ $HOME/ArchMatic/KDErice/.kde4/share/config
cp -r $HOME/.local/share/dolphin $HOME/ArchMatic/KDErice/.local/share/dolphin
cp -r $HOME/.local/share/plasma $HOME/ArchMatic/KDErice/.local/share/plasma