#!/bin/bash

export PATH=$PATH:~/.local/bin
cp -r $HOME/ArchMatic/dotfiles/.config $HOME/.config/
pip install konsave
konsave -i kde.knsv
konsave -a kde
