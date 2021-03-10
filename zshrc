source ~/.proxy_configurer

# Package Manager
source ~/.config/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle nvm
antigen bundle npm
antigen bundle rvm
antigen bundle rails
antigen bundle fzf
antigen bundle ripgrep
antigen bundle httpie
antigen bundle git-auto-fetch
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen bundle rupa/z
antigen bundle zdharma/zsh-diff-so-fancy
antigen bundle paulirish/git-open
if [ "$(uname 2> /dev/null)" != "Linux" ]; then
    antigen bundle softmoth/zsh-vim-mode
fi
antigen apply

if hash rg 2>/dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --glob="!bin" --glob="!build" --glob="!node_modules"'
fi
# Setting Environment Variables
set -o ignoreeof
export PATH=$HOME/bin:/usr/local/bin:~/.composer/vendor/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export VISUAL=vim
export EDITOR="$VISUAL"
export NVM_AUTO_USE=true
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

# # Set Vi Keybindings
bindkey -v
bindkey "^?" backward-delete-char
bindkey "^[[3~" delete-char
bindkey '^r' history-incremental-search-backward
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward
export KEYTIMEOUT=25

# Aliases
alias init-venv="python -m virtualenv venv"
alias init-venv3="python3 -m virtualenv venv"
alias activate="source venv/bin/activate"
alias stop="pkill -f "
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias howto="alias | grep $1"
alias fz='vim $(fzf)'
alias vi='vim'
alias dps='docker ps'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcb='docker-compose build --no-cache'
alias dcd='docker-compose down'
alias dcs='docker-compose stop'
alias dsh='docker exec -it $1 /bin/bash'
alias rm-containers='docker container rm $(docker container ls -aq)'
alias rm-images='docker image prune -a'
alias slack-dark-theme='cat ~/.slack_darkmode.js >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js'
# if type nvim > /dev/null 2>&1; then
#   alias vim='nvim'
# fi
# unalias rg 2>/dev/null

pfind(){
    lsof -t -i :$1
}

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
j() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
c() {
  [ $# -gt 0 ] && _z "$*" && return
  code "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
i() {
  [ $# -gt 0 ] && _z "$*" && return
  idea "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local inst=$(brew search | fzf -m)

  if [ $inst ]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
bup() {
  local upd=$(brew leaves | fzf -m)

  if [ $upd ]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [ $uninst ]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [C]ask [I]nstall [P]lugin
cip() {
  local inst=$(brew search --casks | fzf -m)

  if [ $inst ]; then
    for prog in $(echo $inst);
    do; brew install --cask $prog; done;
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [C]ask [C]lean [P]lugin (e.g. uninstall)
ccp() {
  local uninst=$(brew list --cask | fzf -m)

  if [ $uninst ]; then
    for prog in $(echo $uninst);
    do; brew uninstall --cask $prog; done;
  fi
}

if [ -n "$(command -v apt-get)" ]; then
    install() {
      local inst=$(apt-cache search '.*' | fzf -m)

      if [ $inst ]; then
          local prog=$(echo "$inst" | cut -d' ' -f1)
          sudo apt-get -y install $prog
      fi
    }
fi
if [ -n "$(command -v yum)" ]; then
    install() {
      local inst=$(yum list available | fzf -m)

      if [ $inst ]; then
          local prog=$(echo "$inst" | cut -d' ' -f1)
          sudo yum install -y $prog
      fi
    }
fi

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
