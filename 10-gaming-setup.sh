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

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf



cd /home/$(whoami)/Documents/
mkdir temp

pacman -Syy --noconfirm 

PS3='Please enter your GPU choice: '
options=("Nvidia-tkg" "AMDGPU" "Quit")
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
        "AMDGPU")
            echo "You chose AMDGPU"
            pacman -S xf86-video-amdgpu --noconfirm --needed
            ;;
        "Continue"|"Q"|"Quit"|*)
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

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

#git clone https://gitlab.com/garuda-linux/themes-and-settings/settings/performance-tweaks.git
#cd performance-tweaks
#makepkg -si --noconfirm

sudo sysctl -w net.core.netdev_max_backlog = 16384
sudo sysctl -w net.core.somaxconn = 8192
sudo sysctl -w net.core.rmem_default = 1048576
sudo sysctl -w net.core.rmem_max = 16777216
sudo sysctl -w net.core.wmem_default = 1048576
sudo sysctl -w net.core.wmem_max = 16777216
sudo sysctl -w net.core.optmem_max = 65536
sudo sysctl -w net.ipv4.tcp_rmem = 4096 1048576 2097152
sudo sysctl -w net.ipv4.tcp_wmem = 4096 65536 16777216
sudo sysctl -w net.ipv4.udp_rmem_min = 8192
sudo sysctl -w net.ipv4.udp_wmem_min = 8192
sudo sysctl -w net.ipv4.tcp_fastopen = 3
sudo sysctl -w net.ipv4.tcp_max_syn_backlog = 8192
sudo sysctl -w net.ipv4.tcp_max_tw_buckets = 2000000
sudo sysctl -w vm.swappiness = 10


echo -e "\nDone!\n"

rm -rf /home/$(whoami)/Documents/temp


################################################################################
#
# Chris, if you read this. Please look into here!
# https://gitlab.com/gabmus/bestArch#use-systemd-boot
# This is a blessing from the gods.
# - Thanks, Chris
################################################################################
