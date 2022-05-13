#!/usr/bin/env bash

sh <(curl -L https://nixos.org/nix/install) --daemon
sudo su - $USER -c 'bash ~/.dotfiles/setup_common.sh'
