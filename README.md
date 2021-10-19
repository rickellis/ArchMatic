# Titus ArchMatic Installer Script

<img src="https://i.imgur.com/Yn29sze.png" />

This README contains the steps I do to install and configure a fully-functional Arch Linux installation containing a desktop environment, all the support packages (network, bluetooth, audio, printers, etc.), along with all my preferred applications and utilities. The shell scripts in this repo allow the entire process to be automated.)

---

## Setup Boot and Arch ISO on USB key

First, setup the boot USB, boot arch live iso, and run the `archmatic.sh` from terminal.

Note: Still working on automated Intel systems and Gaming tweaks

```
pacman -Sy git
git clone https://github.com/ChrisTitusTech/ArchMatic
cd ArchMatic
./archmatic.sh
```

### System Description
This is completely automated arch install of the KDE desktop environment on arch using all the packages I use on a daily basis. 

### Troubleshooting Arch Linux

__[Arch Linux Installation Guide](https://github.com/rickellis/Arch-Linux-Install-Guide)__

#### No Wifi

```bash
sudo wifi-menu`
```
