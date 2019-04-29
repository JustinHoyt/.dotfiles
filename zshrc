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

# Set Vi Keybindings
set -o vi
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward

# Aliases
alias dotfiles="cd ~/.dotfiles"
alias init-venv="python -m venv venv"
alias activate="source venv/bin/activate"
alias python="python3"
alias pip="pip3"
alias stop="pkill -f "
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vimrc="cd ~/.vim"
alias howto="alias | grep $1"
alias fz='vim $(fzf)'
alias vi='vim'
alias algo='cd ~/development/interview-practice'
alias vca='cd ~/development/vca'
alias vca-ui='cd ~/development/vca-ui'
alias agent='cd ~/development/agent-service'
alias dps='docker ps'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcb='docker-compose build'
alias dcd='docker-compose down'
alias dcs='docker-compose stop'
alias rm-containers='docker container rm $(docker container ls -aq)'
alias rm-images='docker image prune -a'
alias dev='cd ~/development'
alias gl='git pull && git submodule update'
alias slack-dark-theme='cat ~/.slack_darkmode.js >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js'

pfind(){
    lsof -t -i :$1
}

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
