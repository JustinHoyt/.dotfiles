export ZSH=/Users/justinhoyt/.oh-my-zsh
export PATH=$HOME/bin:/usr/local/bin:~/.composer/vendor/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="/Users/justinhoyt/anaconda3/bin:$PATH"
ZSH_THEME="agnoster"
DEFAULT_USER=justinhoyt
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vimrc="cd ~/.vim"
alias howto="alias | grep $1"
alias fz='vim $(fzf)'
alias vi='vim'
alias algo='cd ~/development/interview-practice'
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
fi

proxyon() {
    export http_proxy=***REMOVED***
    export https_proxy=$http_proxy
    export no_proxy=.ford.com,localhost,127.0.0.1,204.130.41.105*
}

proxyoff() {
    export http_proxy=
    export https_proxy=
    export no_proxy=
}

set -o vi
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward
export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"
