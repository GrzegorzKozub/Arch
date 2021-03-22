# Arch

Automated Arch Linux installation

## Prerequisites

* Windows, along with the EFI partition are already installed. EFI partition size is increased to 512 MB
* There's at least 80 GB unassigned space on the disk for Arch
* In Windows, real time is set to UTC following [this guide](https://wiki.archlinux.org/index.php/Time#UTC_in_Windows)

## Archiso

1. Download the ISO from [here](https://www.archlinux.org/download/)
2. Create the USB following [this guide](https://wiki.archlinux.org/index.php/USB_flash_installation_media#Using_Rufus) using ISO mode and not DD mode
3. Add `video=1280x720` to `options` in all `loader\entries\archiso-x86_64-*.conf` files
4. Make the USB compatible with Secure Boot following [this answer](https://unix.stackexchange.com/questions/320078/how-to-boot-arch-linux-installation-medium-with-secure-boot-enabled)
5. Copy this `arch` directory to `.arch` folder on the USB. When booted from archiso it will be mounted at `/run/archiso/bootmnt/.arch`
6. When booting from the USB for the first time, enrol hash for `arch/boot/x86_64/vmlinuz` and `EFI/boot/loader.efi`

## Installation

1. Boot from archiso
2. Run `source ~/arch/drifter.zsh`, `source ~/arch/pascal.zsh` or `source ~/arch/turing.zsh`
3. Once per machine run `~/arch/disk.zsh`, otherwise run `~/arch/unlock.zsh`
4. Run `~/arch/system.zsh`
5. Once per machine run `~/arch/boot.zsh`
6. Reboot to Arch and login as normal user
7. Run `~/code/arch/services.zsh`
8. Reboot to Gnome, login as normal user, connect to internet and mount archiso
9. Run `~/code/arch/apps.zsh`
10. Reboot

## Manual config

1. Setup Chrome
  - For Chromium, add Polish language and enable it for spell check
  - For Google Chrome, enable enhanced spell check
  - Disable continuing in the background
  - Enable `chrome://flags/#enable-webrtc-pipewire-capturer`
2. Setup `networkmanager-openconnect`
  - Work around missing `--no-dtls` support as per [this issue](https://gitlab.gnome.org/GNOME/NetworkManager-openconnect/issues/7) by executing `iptables -I OUTPUT -d <VPN server> -p udp --dport 443 -j REJECT`

