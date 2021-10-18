#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------
source install.conf
echo -e "\nInstalling Base System\n"

PKGS=(
'gamemode'
'linux-tkg-pds'
'linux-tkg-pds-headers'
'wine-tkg-fsync-git'
'lutris'
'auto-cpufreq'
'vkBasalt'
'goverlay'
)

pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf



cd /home/$(whoami)/Documents/
mkdir temp

PS3='Please enter your GPU choice: '
options=("Nvidia-tkg" "AmdVLK" "AMDGPU" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Nvidia-tkg")
            echo "You chose Nvidia-tkg"
            $nvidia = true
            git clone https://github.com/Frogging-Family/nvidia-all.git
            cd nvidia-all
            makepkg -si
            ;;
        "AmdVLK")
            echo "You chose AmdVLK"
            git clone https://github.com/Frogging-Family/amdvlk-opt.git
            cd amdvlk-opt
            makepkg -si  
            ;;
        "AMDGPU")
            echo "You chose AMDGPU"
            pacman -S xf86-video-amdgpu --noconfirm --needed
            ;;
        "Continue")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

read -p "Do you want Emulators (y/n)?" choice
case "$choice" in 
  y|Y ) PS3='Please enter your Emulator choice: '
options=("Yuzu" "YuzuEA" "Ryujinx" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Yuzu")
            echo "You chose Yuzu"
            sudo pacman -S yuzu --noconfirm --needed
            ;;
        "YuzuEA")
            echo "You chose YuzuEA"
            sudo pacman -S yuzu-early-access --noconfirm --needed
            ;;
        "Ryujinx")
            echo "You chose Ryujinx"
            pacman -S ryujinx-git --noconfirm --needed
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done;;
  n|N ) echo "";;
  * ) echo "invalid";;
esac

# sudo pacman -S yuzu-early-access --noconfirm --needed

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nInstalling Base System Complete\n"

echo -e "\nEnableing Services and Tweaking\n"

systemctl --user enable gamemoded && systemctl --user start gamemoded

#if($nvidia == true) then
 #   nvidia-xconfig
 #   mv /etc/X11/xorg.conf /etc/X11/xorg.conf.d/20-nvidia.conf
# cat 'Option         "TripleBuffer" "on"
#Option         "Coolbits" "28"' >> /etc/X11/xorg.conf.d/20-nvidia.conf
#
#
#fi

git clone https://gitlab.com/garuda-linux/themes-and-settings/settings/performance-tweaks.git
cd performance-tweaks
makepkg -si --noconfirm

echo -e "\nDone!\n"

rm -rf /home/$(whoami)/Documents/temp

<<EOF>>/home/$(whoami)/Documents/install.log