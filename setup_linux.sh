#!/usr/bin/env bash

sh <(curl -L https://nixos.org/nix/install) --daemon
sudo su - $USER -c 'bash setup_common.sh'
