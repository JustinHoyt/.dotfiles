source ~/.proxy_url
# Turns Proxy on
proxy() {
    export http_proxy=$proxy_url
    export https_proxy=$proxy_url
    export HTTP_PROXY=$proxy_url
    export HTTPS_PROXY=$proxy_url
    export no_proxy=.ford.com,localhost,127.0.0.1,204.130.41.105*
}

# Turns Proxy off
noproxy() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset no_proxy
}

# Set Proxy if on Ford Network
noproxy
wget -q --spider http://google.com
if [[ $? != 0 ]]; then
    echo "On ford network. Setting proxy"
    proxy
fi

# Package Manager
source ~/.config/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen bundle lukechilds/zsh-nvm
antigen bundle rupa/z
antigen bundle zdharma/zsh-diff-so-fancy
antigen bundle paulirish/git-open
antigen bundle unixorn/rvm-plugin
antigen apply

# Setting Environment Variables
export PATH=$HOME/bin:/usr/local/bin:~/.composer/vendor/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export VISUAL=vim
export EDITOR="$VISUAL"
export NVM_AUTO_USE=true
export FZF_DEFAULT_COMMAND='fd'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0'
rvm use ruby-2.5.1

# Set Vi Keybindings
set -o vi
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward

# Aliases
alias init-venv="python -m venv venv"
alias activate="source venv/bin/activate"
alias python="python3"
alias pip="pip3"
alias stop="pkill -f "
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias howto="alias | grep $1"
alias fz='vim $(fzf)'
alias vi='vim'
alias dps='docker ps'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcs='docker-compose stop'
alias rm-containers='docker container rm $(docker container ls -aq)'
alias rm-images='docker image prune -a'
alias gl='git pull && git submodule update'
alias slack-dark-theme='cat ~/.slack_darkmode.js >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js'

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

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
bup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [C]ask [I]nstall [P]lugin
cip() {
  local inst=$(brew search --casks | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew cask install $prog; done;
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
ccp() {
  local uninst=$(brew cask list | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew cask uninstall $prog; done;
  fi
}

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
