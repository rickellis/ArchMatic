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
'alsa-plugins' # audio plugins
'alsa-utils' # audio utils
'amd-ucode' # AMD CPU ucode driver
'ark' # compression
'audiocd-kio' 
'autoconf' # build
'automake' # build
'base'
'bash-completion'
'bind'
'binutils'
'bison'
'bluedevil'
'bluez'
'bluez-libs'
'breeze'
'breeze-gtk'
'bridge-utils'
'btrfs-progs'
'celluloid' # video players
'cmatrix'
'code' # Visual Studio code
'cronie'
'cups'
'dhcpcd'
'dialog'
'discover'
'dmidecode'
'dnsmasq'
'dolphin'
'dosfstools'
'drkonqi'
'edk2-ovmf'
'efibootmgr' # EFI boot
'exfat-utils'
'flex'
'fuse2'
'fuse3'
'fuseiso'
'gamemode'
'gcc'
'gimp' # Photo editing
'git'
'gparted' # partition management
'gptfdisk'
'groff'
'grub'
'grub-customizer'
'gst-libav'
'gst-plugins-good'
'gst-plugins-ugly'
'haveged'
'htop'
'iptables-nft'
'jdk-openjdk' # Java 17
'kactivitymanagerd'
'kate'
'kcalc'
'kcharselect'
'kcron'
'kde-cli-tools'
'kde-gtk-config'
'kdecoration'
'kdenetwork-filesharing'
'kdeplasma-addons'
'kdesdk-thumbnailers'
'kdialog'
'keychain'
'kfind'
'kgamma5'
'kgpg'
'khotkeys'
'kinfocenter'
'kmenuedit'
'kmix'
'konsole'
'kscreen'
'kscreenlocker'
'ksshaskpass'
'ksystemlog'
'ksystemstats'
'kwallet-pam'
'kwalletmanager'
'kwayland-integration'
'kwayland-server'
'kwin'
'kwrite'
'kwrited'
'layer-shell-qt'
'libguestfs'
'libkscreen'
'libksysguard'
'libnewt'
'libtool'
'linux'
'linux-lts'
'linux-firmware'
'linux-headers'
'lsof'
'lutris'
'lzop'
'm4'
'make'
'milou'
'nano'
'nautilus' # GNOME file manager
'neofetch'
'networkmanager'
'ntfs-3g'
'okular'
'openbsd-netcat'
'openssh'
'os-prober'
'oxygen'
'p7zip'
'pacman-contrib'
'patch'
'pkgconf'
'plasma-browser-integration'
'plasma-desktop'
'plasma-disks'
'plasma-firewall'
'plasma-integration'
'plasma-nm'
'plasma-pa'
'plasma-sdk'
'plasma-systemmonitor'
'plasma-thunderbolt'
'plasma-vault'
'plasma-workspace'
'plasma-workspace-wallpapers'
'polkit-kde-agent'
'powerdevil'
'powerline-fonts'
'print-manager'
'pulseaudio'
'pulseaudio-alsa'
'pulseaudio-bluetooth'
'python-pip'
'qemu'
'rsync'
'sddm-kcm'
'spectacle'
'steam'
'sudo'
'swtpm'
'synergy'
'systemsettings'
'terminator'
'terminus-font'
'texinfo'
'traceroute'
'ufw'
'unrar'
'unzip'
'usbutils'
'vde2'
'vim'
'virt-manager'
'virt-viewer'
'wget'
'which'
'wine-gecko'
'wine-mono'
'winetricks'
'xdg-desktop-portal-kde'
'xdg-user-dirs'
'xorg-server'
'xorg-xinit'
'zeroconf-ioslave'
'zip'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nDone!\n"

if [ $(whoami) = "root"  ];
then
    [ ! -d "/home/$username" ] && useradd -m -g users -G wheel -s /bin/bash $username 
    cp -R /root/ArchMatic /home/$username/
    echo "--------------------------------------"
    echo "--      Set Password for $username  --"
    echo "--------------------------------------"
    echo "Enter password for $username user: "
    passwd $username
    cp /etc/skel/.bash_profile /home/$username/
    cp /etc/skel/.bash_logout /home/$username/
    cp ~/ArchMatic/.bashrc /home/$username/.bashrc
    cp ~/ArchMatic/.bashrc /root/.bashrc
    chown -R $username: /home/$username
    su $username
    echo "Switched to user mode"
else
	echo "You are already a user proceed with aur installs"
fi