export ZSH=/Users/justinhoyt/.oh-my-zsh
export PATH=$HOME/bin:/usr/local/bin:~/.composer/vendor/bin:$PATH
export PATH=/usr/local/sbin:$PATH
ZSH_THEME=""
DEFAULT_USER=justinhoyt
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias dotfiles="cd ~/.dotfiles"
alias init-env="python -m venv env"
alias activate="source env/bin/activate"
alias python="python3"
alias pip="pip3"
alias killpy="pkill -f python"
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
alias dev='cd ~/development'
export FZF_DEFAULT_COMMAND='fd'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
brun() {
    echo "\n${WHITE}This is an alias for \"SPRING_PROFILES_ACTIVE=$1 ./gradlew bootRun\"${NC}\n"
    SPRING_PROFILES_ACTIVE=$1 ./gradlew bootRun
}

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
    echo "Not on Ford Network, don't set proxy"
else
    echo "On ford network, setting proxy"
    export http_proxy=***REMOVED***
    export https_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export no_proxy=.ford.com,localhost,127.0.0.1,204.130.41.105*
fi

proxy() {
    export http_proxy=***REMOVED***
    export https_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export no_proxy=.ford.com,localhost,127.0.0.1,204.130.41.105*
}

noproxy() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset no_proxy
}

set -o vi
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"
autoload -U promptinit; promptinit
prompt pure
