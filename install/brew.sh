#!/bin/sh

info "run install/brew.sh"

# Check for Homebrew and install if we don't have it
if test ! $(which brew)
then
  info 'install homebrew'
  cmd '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
fi

info "update homebrew"
cmd 'brew update'

BREWFILE=$DOTFILES_ROOT/install/Brewfile
info 'install all dependencies with bundle'
cmd "brew bundle -v --file=$BREWFILE"
