#!/usr/bin/env bash

sh <(curl -L https://nixos.org/nix/install) --daemon
echo "${HOME}/.nix-profile/bin/zsh" | sudo -S tee -a /etc/shells
su - $USER -c 'bash ~/.dotfiles/setup_common.sh'
