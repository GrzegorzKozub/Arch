#!/usr/bin/env bash

set -e -o verbose

# timezone

ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc

# localization

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/#pl_PL.UTF-8 UTF-8/pl_PL.UTF-8 UTF-8/' /etc/locale.gen

locale-gen

echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'LC_MEASUREMENT=pl_PL.UTF-8' >> /etc/locale.conf
echo 'LC_MONETARY=pl_PL.UTF-8' >> /etc/locale.conf
echo 'LC_NUMERIC=pl_PL.UTF-8' >> /etc/locale.conf
echo 'LC_PAPER=pl_PL.UTF-8' >> /etc/locale.conf
echo 'LC_TIME=pl_PL.UTF-8' >> /etc/locale.conf

echo 'KEYMAP=pl2' > /etc/vconsole.conf
echo 'FONT=Lat2-Terminus16.psfu.gz' >> /etc/vconsole.conf
echo 'FONT_MAP=8859-2' >> /etc/vconsole.conf

# network

echo $MY_HOSTNAME > /etc/hostname

echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1       localhost' >> /etc/hosts
echo "127.0.1.1 $MY_HOSTNAME.localdomain $MY_HOSTNAME" >> /etc/hosts

sed -i 's/myhostname resolve/myhostname mdns_minimal [NOTFOUND=return] resolve/' /etc/nsswitch.conf

# root password

set +e

(exit 1)
while [[ ! $? = 0 ]]; do
  passwd
done

set -e

# normal user

useradd -m -g users -G wheel -s /bin/zsh greg

set +e

(exit 1)
while [[ ! $? = 0 ]]; do
  passwd greg
done

set -e

echo 'greg ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo

# temp zsh profile

touch /home/greg/.zshrc
chown greg:users /home/greg/.zshrc

# ampere sleep fix

if [[ $MY_HOSTNAME = 'ampere' ]]; then
  echo 'w /proc/acpi/wakeup - - - - GPP0' > /usr/lib/tmpfiles.d/ampere.conf
fi

# operating system continued

cp `dirname $0`/system3.zsh /home/greg
su greg --command '~/system3.zsh'
rm /home/greg/system3.zsh

# kernel hooks: encrypt, lvm2 and resume

sed -Ei 's/^HOOKS=.+$/HOOKS=(base udev autodetect modconf block encrypt lvm2 resume filesystems keyboard fsck)/' /etc/mkinitcpio.conf
mkinitcpio -p linux

# pacman

reflector --country Poland --sort rate --save /etc/pacman.d/mirrorlist
sed -i 's/#Color/Color/' /etc/pacman.conf

# scripts

su greg --command 'mkdir ~/code; git clone https://github.com/GrzegorzKozub/arch.git ~/code/arch'

