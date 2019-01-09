# Package Manager
source ~/.config/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen apply

# Setting Environment Variables
export PATH=$HOME/bin:/usr/local/bin:~/.composer/vendor/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
export FZF_DEFAULT_COMMAND='fd'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Set Vi Keybindings
set -o vi
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward

# Aliases
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

# Set Environemnt and Bootrun an Application
brun() {
    echo "\n${WHITE}This is an alias for \"SPRING_PROFILES_ACTIVE=$1 ./gradlew bootRun\"${NC}\n"
    SPRING_PROFILES_ACTIVE=$1 ./gradlew bootRun
}

# Set Proxy if on Ford Network
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
else
    echo "On ford network. Setting proxy"
    export http_proxy=***REMOVED***
    export https_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
    export no_proxy=.ford.com,localhost,127.0.0.1,204.130.41.105*
fi

# Turns Proxy on
proxy() {
    export http_proxy=***REMOVED***
    export https_proxy=$http_proxy
    export HTTP_PROXY=$http_proxy
    export HTTPS_PROXY=$http_proxy
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
