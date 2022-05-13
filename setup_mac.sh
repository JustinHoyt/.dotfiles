#!/usr/bin/env bash

# Install package manager - Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew and install packages
brew update
brew tap caskroom/versions
brew bundle

bash setup_linux.sh
