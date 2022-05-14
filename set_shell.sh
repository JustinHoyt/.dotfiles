echo "${HOME}/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
chsh -s "${HOME}/.nix-profile/bin/zsh"
