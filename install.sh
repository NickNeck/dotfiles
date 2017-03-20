#!/bin/sh

echo ""
echo "Setting up your Mac..."
echo ""

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
echo "Update homebrew"
brew update
echo ""

# Install all our dependencies with bundle (See Brewfile)
brew tap Homebrew/bundle
brew bundle

echo ""
echo "...ready"
echo ""
