# source ~/.proxy_configurer

DISABLE_MAGIC_FUNCTIONS=true

if hash rg 2>/dev/null; then
    export FZF_DEFAULT_COMMAND='rg -S --files --no-ignore-vcs --hidden --glob="!bin" --glob="!build" --glob="!node_modules"'
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
alias v='vim'
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
alias xml='tidy -xml -i -q <<<'
alias xmlp='pbpaste | tidy -xml -i -q'
alias vim='nvim'
unalias rg 2>/dev/null
alias rg='rg --smart-case --glob="!coverage"'
# alias darkMode="2>/dev/null defaults read -g AppleInterfaceStyle"
alias bgd='kitty +kitten themes --reload-in=all One Dark'
alias bgl='kitty +kitten themes --reload-in=all Atom One Light'
if command -v kitty &> /dev/null; then
  if defaults read -g AppleInterfaceStyle &>/dev/null; then
    kitty +kitten themes --reload-in=all One Dark
  else
    kitty +kitten themes --reload-in=all Atom One Light
  fi
fi

pfind(){
    lsof -t -i :$1
}

unalias z 2> /dev/null
j() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
bip() {
  local app=$(brew formulae | fzf -m)
  if [ $app ]; then
    brew install $app
  fi
}

# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
bup() {
  local app=$(brew leaves | fzf -m)
  if [ -n "$app" ]; then
    brew upgrade "$app"
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
bcp() {
  local app=$(brew leaves | fzf -m)
  if [ -n "$app" ]; then
    brew uninstall "$app"
  fi
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [C]ask [I]nstall [P]lugin
cip() {
  local app=$(brew casks | fzf -m)
  if [ -n "$app" ]; then
    brew install --cask "$app"
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [C]ask [C]lean [P]lugin (e.g. uninstall)
ccp() {
  local app=$(brew list --cask | fzf -m)
  if [ -n "$app" ]; then
    brew uninstall "$app"
  fi
}

if [ -n "$(command -v apt-get)" ]; then
    install() {
      local app=$(apt-cache search '.*' | fzf -m)

      if [ -n $app ]; then
          local app=$(echo "$app" | cut -d' ' -f1)
          sudo apt-get -y install "$app"
      fi
    }
fi
if [ -n "$(command -v yum)" ]; then
    install() {
      local app=$(yum list available | fzf -m)

      if [ -n $app ]; then
          local app=$(echo "$app" | cut -d' ' -f1)
          sudo yum install -y "$app"
      fi
    }
fi

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Theme
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# <Ctrl-r> to search history
zinit ice wait lucid
zinit light zdharma-continuum/history-search-multi-word

# Autocompletions
zinit ice wait lucid
zinit light zsh-users/zsh-completions

# Jump to file plugin
zinit ice wait lucid
zinit light rupa/z

# `git open` to open current branch in a browser
zinit ice wait lucid
zinit light paulirish/git-open

# Syntax highlighting
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# Git shortcuts
zinit ice wait lucid
zinit snippet OMZP::git

# Automatically runs `git fetch --all` in the background
zinit ice wait lucid
zinit snippet OMZP::git-auto-fetch

# Autopair
zinit ice wait lucid
zinit load hlissner/zsh-autopair

# Autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# Vi mode
zinit ice wait lucid depth=1
zinit light jeffreytse/zsh-vi-mode

# FZF is a fuzzy file finder
zinit pack"binary" for fzf

# ripgrep is a replacement for find written in rust
zinit ice wait lucid as"command" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep

# fd is a replacement for find written in rust
zinit ice wait lucid as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd
