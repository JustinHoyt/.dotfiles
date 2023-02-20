#! /bin/bash

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh

# alias

#bash-it disable alias all

bash-it enable alias apt
bash-it enable alias general
bash-it enable alias git

# plugin

#bash-it disable plugin all

bash-it enable plugin base
bash-it enable plugin blesh
bash-it enable plugin history
bash-it enable plugin history-search

# completion

#bash-it disable completion all

bash-it enable completion aliases
bash-it enable completion bash-it
bash-it enable completion system
