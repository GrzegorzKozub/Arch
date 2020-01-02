set -e -o verbose

# dirs

if [ ! -d ~/AUR ]; then mkdir ~/AUR; fi

# yay

pushd ~/AUR

if [ -d yay ]; then rm -rf yay; fi
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
git clean -fdx
cd ..

popd

# firmware and power saving

yay -S --aur --noconfirm \
  aic94xx-firmware wd719x-firmware \
  laptop-mode-tools

