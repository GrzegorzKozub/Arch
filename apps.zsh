#!/usr/bin/env zsh

set -e -o verbose

# validation

[[ . = `dirname $0` ]] && exit 1

# pacman refresh

sudo pacman -Sy --noconfirm
sudo pacman-key --refresh-keys

# git and openssh

sudo pacman -S --noconfirm \
  git \
  openssh

paru -S --aur --noconfirm \
  git-extras \
  gitflow-avh \
  gitflow-zshcompletion-avh

# dotfiles init

sudo pacman -S --noconfirm \
  stow

. `dirname $0`/dotfiles.zsh

. ~/code/dotfiles/init.zsh
. ~/code/history/init.zsh
. ~/code/keys/init.zsh

# fonts

sudo pacman -S --noconfirm \
  gnu-free-fonts \
  noto-fonts \
  noto-fonts-emoji \
  ttf-dejavu \
  ttf-fira-code \
  ttf-liberation

# gnome

. `dirname $0`/gdm.zsh
. `dirname $0`/gnome.zsh
. `dirname $0`/terminal.zsh

# terminal

sudo pacman -S --noconfirm \
  alacritty

# common

sudo pacman -S --noconfirm \
  fd \
  freerdp \
  fzf \
  graphviz \
  htop \
  imwheel \
  jq \
  man-db man-pages \
  p7zip \
  ripgrep \
  rsync \
  trash-cli \
  wget \
  wkhtmltopdf \
  xclip \
  xdotool \
  xorg-xrandr \
  youtube-dl ffmpeg \
  zip

paru -S --aur --noconfirm \
  wrk2-git

if [[ $HOST = 'turing' ]]; then

  sudo pacman -S --noconfirm \
    nvtop

fi

# zsh, tmux and lf

sudo pacman -S --noconfirm \
  tmux \
  zsh zsh-completions

paru -S --aur --noconfirm \
  lf

rm -rf ~/.bash*

# vim and neovim

sudo pacman -S --noconfirm \
  astyle ctags editorconfig-core-c gvim tidy \
  glibc neovim

paru -S --aur --noconfirm \
  hadolint-bin

# docker

sudo pacman -S --noconfirm \
  docker docker-machine

sudo usermod -aG docker $USER

sudo systemctl enable docker.service
sudo systemctl start docker.service

# aws

paru -S --aur --noconfirm \
  aws-cli-v2-bin

# dev

sudo pacman -S --noconfirm \
  dotnet-sdk \
  elixir \
  go \
  nodejs npm \
  perl \
  python python-pip \
  ruby \
  rust

# apps

sudo pacman -S --noconfirm \
  chromium chrome-gnome-shell \
  flameshot \
  keepassxc qt5-styleplugins \
  mpv celluloid \
  openconnect networkmanager-openconnect \
  peek gifski gst-plugins-good gst-plugins-ugly \
  obs-studio

paru -S --aur --noconfirm \
  google-chrome
  postman-bin \
  slack-desktop \
  visual-studio-code-bin

# for APP in \
  # flameshot \
  # org.keepassxc.KeePassXC
# do
  # cp /usr/share/applications/$APP.desktop ~/.local/share/applications
  # sed -i 's/^Exec=/Exec=\/home\/greg\/code\/arch\/qt.sh /' \
    # ~/.local/share/applications/$APP.desktop
# done

for APP in \
  org.keepassxc.KeePassXC
do
  cp /usr/share/applications/$APP.desktop ~/.local/share/applications
  sed -i 's/^Exec=/Exec=env QT_SCALE_FACTOR_ROUNDING_POLICY=PassThrough /' \
    ~/.local/share/applications/$APP.desktop
done

for APP in \
  Alacritty
do
  cp /usr/share/applications/$APP.desktop ~/.local/share/applications
  sed -i 's/^Exec=/Exec=env WAYLAND_DISPLAY= /' \
    ~/.local/share/applications/$APP.desktop
done

for APP in \
  nvim
do
  cp /usr/share/applications/$APP.desktop ~/.local/share/applications
  sed -i \
    -e 's/^Exec=nvim %F$/Exec=env WAYLAND_DISPLAY= alacritty --command nvim %F/' \
    -e 's/^Terminal=true$/Terminal=false/' \
    ~/.local/share/applications/$APP.desktop
  echo 'NoDisplay=true' >> ~/.local/share/applications/$APP.desktop
done

gsettings set io.github.celluloid-player.Celluloid always-use-floating-controls true
gsettings set io.github.celluloid-player.Celluloid dark-theme-enable false
gsettings set io.github.celluloid-player.Celluloid mpv-config-enable true
gsettings set io.github.celluloid-player.Celluloid mpv-config-file '/home/greg/.config/mpv/mpv.conf'
gsettings set io.github.celluloid-player.Celluloid mpv-options '--hwdec=auto'

# dotfiles install

. ~/code/dotfiles/install.zsh

