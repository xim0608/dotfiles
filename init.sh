#!/bin/sh

set -e

is_not_installed(){
  if ! type $1 > /dev/null 2>&1; then
    echo "$1 is not installed"
    return 0
  else
    echo "$1 is installed"
    return 1
  fi
}

if is_not_installed 'xcode-select'; then
  xcode-select --install
fi

if is_not_installed 'brew'; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
fi

if [ ! -d $HOME/dotfiles ]; then
  git clone https://github.com/xim0608/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles
~/dotfiles/install.sh
