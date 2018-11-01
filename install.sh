set -o verbose

mkfs.ext4 /dev/mapper/vg1-$1

swapon /dev/mapper/vg1-swap
mount /dev/mapper/vg1-$1 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p2 /mnt/boot

rm /mnt/boot/*.img
rm /mnt/boot/vmlinuz-linux

pacstrap /mnt \
  base base-devel \
  sudo reflector dialog wpa_supplicant zsh \
  intel-ucode \
  xf86-video-intel xorg-server gnome gnome-tweak-tool networkmanager \
  git

genfstab -U /mnt > /mnt/etc/fstab

cp -r `dirname $0`/../Arch /mnt/root
arch-chroot /mnt ~/Arch/config.sh
rm -rf /mnt/root/Arch

swapoff /dev/mapper/vg1-swap
umount -R /mnt

