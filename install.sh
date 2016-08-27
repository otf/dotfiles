#!/bin/sh

sudo sh -c 'echo \'\n\
[archlinuxfr]\n\
SigLevel = Never\n\
Server = http://repo.archlinux.fr/$arch\n\' >> /etc/pacman.conf'

sudo pacman --sync --refresh --noconfirm yaourt
yaourt -Syua --noconfirm
yaourt -S --noconfirm otf-ipaexfont ttf-roboto-font ttf-ricty
yaourt -S --noconfirm zsh zsh-completions
yaourt -S --noconfirm xorg-xinit xorg-xmodmap xcursor-vanilla-dmz
yaourt -S --noconfirm xmonad xmonad-contrib feh dzen2 conky
yaourt -S --noconfirm neovim
yaourt -S --noconfirm rxvt-unicode
yaourt -S --noconfirm fcitx-skk fcitx-im skk-jisyo fcitx-configtool
yaourt -S --noconfirm xdg-utils 
yaourt -S --noconfirm slack-desktop
yaourt -S --noconfirm xfreerdp
yaourt -S --noconfirm firefox
yaourt -S --noconfirm git tk gsfonts perl-term-readkey
yaourt -S --noconfirm gnu-netcat

ln -s ./.xinitrc ~/.xinitrc
mkdir ~/.xmonad ; ln -s ./xmonad.hs ~/.xmonad/xmonad.hs
ln -s ./.Xdefaults ~/.Xdefaults
mkdir ~/.conky ; ln -s ./.conkyrc ~/.conkyrc
ln -s ./.Xmodmap ~/.Xmodmap
ln -s ./.zshrc ~/.zshrc
ln -s ./.vimperatorrc ~/.vimperatorrc
