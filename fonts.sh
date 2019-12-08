set -e -o verbose

# fonts

sudo pacman -S --noconfirm gnu-free-fonts noto-fonts-emoji ttf-fira-mono

cd ~/AUR
git clone https://aur.archlinux.org/otf-fira-code.git
cd otf-fira-code

makepkg -si --noconfirm
git clean -fdx

cd ~

