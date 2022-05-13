#!/usr/bin/env bash

# Symbolically link all dotfiles
~/.dotfiles/install

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install

# If this user's login shell is not already "zsh", attempt to switch.
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    printf "${BLUE}Time to change your default shell to zsh!${NORMAL}\n"
    echo "${HOME}/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
    chsh -s "${HOME}/.nix-profile/bin/zsh"
    env zsh -l
fi

