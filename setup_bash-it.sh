#! /bin/bash

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent --no-modify-config

source "$BASH_IT"/bash_it.sh
