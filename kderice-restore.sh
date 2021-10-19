#!/bin/bash

export PATH=$PATH:~/.local/bin
cp -r $HOME/ArchMatic/dotfiles/ $HOME/.config/
pip install konsave
konsave -i $HOME/ArchMatic/kde.knsv
konsave -a $HOME/ArchMatic/kde
