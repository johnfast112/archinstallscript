#!/bin/sh
pacman-key --init
pacman -Sy archlinux-keyring --noconfirm
pacman -Sy git glibc --noconfirm 
git clone https://github.com/johnfast112/archinstallscript
cd archinstallscript
sed -i 's/rtx4080-arch-vm/tmpArchPc/g' installArch.sh
chmod +x installArch.sh
./installArch.sh
