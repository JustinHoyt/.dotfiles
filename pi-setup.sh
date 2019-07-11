#! /bin/bash
apt update -qy
apt install -qy git nodejs zsh neovim
chsh -s /bin/zsh
echo "Type /bin/zsh to load z shell"
