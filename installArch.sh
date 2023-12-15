#!/bin/sh
#Please use fdisk or cfdisk to configure your drive
#This script is designed to work with /dev/sda1 being your swap partition and /dev/sda2 being your bootable ext4 partition
#TODO remember how to use fdisk so that the partition step can be automated
pacman -Sy archlinux-keyring --noconfirm
mkfs.ext4 /dev/sda2
mkswap /dev/sda1
swapon /dev/sda1 
mount /dev/sda2 /mnt
pacstrap -K /mnt base linux linux-firmware neovim neofetch git grub sudo networkmanager
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash \
  -c "ln -sf /usr/share/zoneinfo/Canada/Mountain /etc/localtime && \
  hwclock --systohc && \
  sed -i 's/##en_US/en_US/g' /etc/locale.gen && \
  locale-gen && \
  echo LANG=en_US.UTF-8 >> /etc/locale.conf && \
  echo rtx4080-arch-vm >> /etc/hostname && \
  mkinitcpio -P && \
  grub-install /dev/sda --target=i386-pc && \
  systemctl enable NetworkManager && \
  grub-mkconfig -o /boot/grub/grub.cfg && \
  passwd root "
