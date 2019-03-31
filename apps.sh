set -e -o verbose

# internet

wifi-menu
sleep 10
#elinks google.com

# mount

if [[ ! $(mount | grep "sda1 on /mnt") ]]; then mount /dev/sda1 /mnt; fi

# git

sudo pacman -S --noconfirm git openssh

cp `dirname $0`/home/greg/.gitconfig ~
mkdir ~/.ssh
cp /mnt/.greg/id_rsa* ~/.ssh
chmod 600 ~/.ssh/id_rsa

# fonts

sudo pacman -S --noconfirm ttf-fira-mono ttf-freefont noto-fonts-emoji

cd ~/AUR
git clone https://aur.archlinux.org/otf-fira-code.git
cd otf-fira-code

makepkg -si --noconfirm
git clean -fdx

cd ~

# zsh and oh-my-zsh

sudo pacman -S --noconfirm wget zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp -r `dirname $0`/home/greg/.oh-my-zsh/custom/themes ~/.oh-my-zsh/custom
cp `dirname $0`/home/greg/.zshrc ~

rm ~/.zshrc.pre-oh-my-zsh

# chrome

cd ~/AUR
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome

makepkg -si --noconfirm
git clean -fdx

cd ~

# keepass

sudo pacman -S --noconfirm keepass

cp `dirname $0`/home/greg/.config/KeePass ~/.config

# nodejs and yarn

sudo pacman -S --noconfirm nodejs yarn

yarn global add \
  @angular/cli \
  babel-cli \
  create-react-app \
  eslint \
  express-generator \
  gulp-cli \
  js-beautify \
  karma-cli \
  pm2 \
  rimraf \
  tslint \
  typescript \
  typescript-formatter \
  yo

# dotnet, go, perl, python and ruby

sudo pacman -S --noconfirm dotnet-sdk go perl python ruby

# docker

sudo pacman -S --noconfirm docker

sudo systemctl enable docker.service
sudo systemctl start docker.service

# vscode

cd ~/AUR
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin

makepkg -si --noconfirm
git clean -fdx

cd ~

# vim

sudo pacman -S --noconfirm astyle ctags editorconfig-core-c fzf ripgrep tidy vim

git clone git@github.com:GrzegorzKozub/Vim.git ~/.vim

# mc

sudo pacman -S --noconfirm mc

# scripts

if [ ! -d ~/Code ]; then mkdir ~/Code; fi
if [ ! -d ~/Code/Arch ]; then rm -rf ~/Code/Arch; fi
git clone git@github.com:GrzegorzKozub/Arch.git ~/Code/Arch

# unmount

umount -R /mnt

