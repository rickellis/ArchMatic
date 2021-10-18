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
'earlyoom'
'ananicy-git'
'libva-vdpau-driver'
)

pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf



cd /home/$(whoami)/Documents/
mkdir temp

pacman -Syy --noconfirm 

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
systemctl enable --now earlyoom

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

touch /etc/init.d/titusscript

cat '#!/bin/bash 
sysctl -w net.core.netdev_max_backlog = 16384
sysctl -w net.core.somaxconn = 8192
sysctl -w net.core.rmem_default = 1048576
sysctl -w net.core.rmem_max = 16777216
sysctl -w net.core.wmem_default = 1048576
sysctl -w net.core.wmem_max = 16777216
sysctl -w net.core.optmem_max = 65536
sysctl -w net.ipv4.tcp_rmem = 4096 1048576 2097152
sysctl -w net.ipv4.tcp_wmem = 4096 65536 16777216
sysctl -w net.ipv4.udp_rmem_min = 8192
sysctl -w net.ipv4.udp_wmem_min = 8192
sysctl -w net.ipv4.tcp_fastopen = 3
sysctl -w net.ipv4.tcp_max_syn_backlog = 8192
sysctl -w net.ipv4.tcp_max_tw_buckets = 2000000
sysctl -w vm.swappiness = 10
' >> /etc/init.d/titusscript
chmod +x /etc/init.d/titusscript
update-rc titusscript defaults 40 1

touch /etc/pacman.d/hooks/nvidia.hook
cat '
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia

[Action]
Depends=mkinitcpio
When=PostTransaction
Exec=/usr/bin/mkinitcpio -P
' >> /etc/pacman.d/hooks/nvidia.hook

touch /home/$(whoami)/.config/mpv/mpv.conf
cat '
vo=vdpau
profile=opengl-hq
hwdec=vdpau
hwdec-codecs=all
scale=ewa_lanczossharp
cscale=ewa_lanczossharp
interpolation
tscale=oversample
' >> /home/$(whoami)/.config/mpv/mpv.conf

systemctl enable fstrim.timer
systemctl enable --now ananicy
mkinitcpio -p linux


echo -e "\nDone!\n"

rm -rf /home/$(whoami)/Documents/temp

<<EOF>>/home/$(whoami)/Documents/install.log

################################################################################
#
# Chris, if you read this. Please look into here!
# https://gitlab.com/gabmus/bestArch#use-systemd-boot
# This is a blessing from the gods.
#
################################################################################