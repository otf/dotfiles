#!/bin/sh

pacman -S wget

if ! which yaourt 1>/dev/null 2>&1 ; then
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
  tar -xvf package-query.tar.gz && rm package-query.tar.gz
  sh -c 'cd package-query && makepkg -si' || { rm -r package-query && fail ; }
  rm -r package-query
  wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz || fail
  tar -xvf yaourt.tar.gz && rm yaourt.tar.gz
  sh -c 'cd yaourt && makepkg -si' || { rm -r yaourt && fail ; }
  rm -r yaourt
fi

if ! which yaourt 1>/dev/null 2>&1 ; then
  echo 'could not install yaourt'
  exit 1
fi

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
yaourt -S --noconfirm zsh-autosuggestions

for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = `basename $0` ] && continue
    ln -snfv `pwd`"/$f" "$HOME"/"$f"
done

