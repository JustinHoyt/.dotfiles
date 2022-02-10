# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source ~/.proxy_configurer

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
zi light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# # Theme
zi ice depth=1
zi light romkatv/powerlevel10k

# <Ctrl-r> to search history
zi ice wait"0b" lucid
zi light zdharma-continuum/history-search-multi-word

# Autosuggestions
zi ice wait"0b" lucid atload"_zsh_autosuggest_start"
zi light zsh-users/zsh-autosuggestions

# Completions
zi ice wait"0b" lucid blockf
zi light zsh-users/zsh-completions

# Syntax highlighting
zi ice wait lucid
zi light zsh-users/zsh-syntax-highlighting

# History substring search on up/down
zi light zsh-users/zsh-history-substring-search
function zvm_before_init() {
  zvm_bindkey viins '^[[A' history-beginning-search-backward
  zvm_bindkey viins '^[[B' history-beginning-search-forward
  zvm_bindkey vicmd '^[[A' history-beginning-search-backward
  zvm_bindkey vicmd '^[[B' history-beginning-search-forward
}

# Jump to file plugin
zi ice wait lucid
zi light rupa/z

zi for \
      OMZL::completion.zsh \
      OMZL::history.zsh \
      OMZL::key-bindings.zsh \

# `git open` to open current branch in a browser
zi ice wait lucid
zi light paulirish/git-open

# Git shortcuts
zi ice wait lucid
zi snippet OMZP::git

# Automatically runs `git fetch --all` in the background
zi ice wait lucid
zi snippet OMZP::git-auto-fetch

# Autopair
zi ice wait lucid
zi load hlissner/zsh-autopair

# Vi mode
zi ice wait lucid depth=1
zi light jeffreytse/zsh-vi-mode

# Manydots magic
zi ice wait lucid
zi autoload'#manydots-magic' for knu/zsh-manydots-magic
setopt autocd

# ripgrep is a replacement for find written in rust
zi ice wait lucid as"command" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
zi light BurntSushi/ripgrep

# fd is a replacement for find written in rust
zi ice wait lucid as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zi light sharkdp/fd

# TREE-SITTER
zi ice wait lucid as"program" from"gh-r" mv"tree* -> tree-sitter" pick"tree-sitter"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
