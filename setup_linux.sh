#!/usr/bin/env bash

if ! command -v nix &> /dev/null; then
    sh <(curl -L https://nixos.org/nix/install) --daemon
fi

echo "${HOME}/.nix-profile/bin/zsh" | sudo -S tee -a /etc/shells
su - $USER -c 'bash ~/.dotfiles/setup_common.sh'
