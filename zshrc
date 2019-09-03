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
antigen bundle nvm
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
antigen apply

if hash rg 2>/dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --glob="!bin" --glob="!build" --glob="!node_modules"'
fi
# Setting Environment Variables
export PATH=$HOME/bin:/usr/local/bin:~/.composer/vendor/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export VISUAL=nvim
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
autoload -Uz surround
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward
export KEYTIMEOUT=25

# Aliases
alias init-venv="python -m virtualenv venv"
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
alias rm-containers='docker container rm $(docker container ls -aq)'
alias rm-images='docker image prune -a'
alias slack-dark-theme='cat ~/.slack_darkmode.js >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js'
alias vim="nvim"
unalias rg 2>/dev/null

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
# mnemonic [C]ask [C]lean [P]lugin (e.g. uninstall)
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
