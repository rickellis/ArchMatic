#!/usr/bin/env bash
#-------------------------------------------------------------------------
#  Arch Linux Post Install Setup and Configuration
#-------------------------------------------------------------------------

echo
echo "CLONING GIT REPOS"
echo

cd ${HOME}/CodeLab

# Git assets
GITREPOS=(
        'Arch-Cheatsheet'
        'Arch-Linux-Install-Guide'
        'AURIC'
        'Bash-Cheatsheet'
        'BashRC'
        'CodeIgniter'
        'ConkyMatic'
        'Dotfiles'
        'jotTablet'
        'Shell-Scripts'
        'Shortcuts'
        'SVG-to-PNG'
        'SVG-Weather-Icons'
        'SYSTR'
        'Utilities'
        'WifiVPN'
        'WebServer'
)

for repo in "${GITREPOS[@]}"; do

    git clone git@github.com:rickellis/${repo}.git

    # HTTP:
    # git clone "https://github.com/rickellis/${repo}.git"
    echo
done

# Hardcode fixer
git clone https://github.com/Foggalong/hardcode-fixer.git

echo
echo "Done!"