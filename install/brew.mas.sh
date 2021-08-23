#!/bin/sh

info "run install/app-store.sh"

# Check for Homebrew and install if we don't have it
if test ! $(which brew)
then
  info 'install homebrew'
  cmd '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
fi

info "update homebrew"
cmd 'brew update'

BREWFILE=$DOTFILES_ROOT/install/app-store/Brewfile
info 'install AppStore apps'
cmd "brew bundle -v --file=$BREWFILE"
