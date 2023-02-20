# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export VISUAL=nvim
export EDITOR="$VISUAL"

# Path to the bash it configuration
export BASH_IT="/home/${USER}/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='bakke'

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

alias v='nvim'
alias rg='rg --smart-case --glob="!coverage"'
alias bgd='kitty +kitten themes --reload-in=all One Dark'
alias bgl='kitty +kitten themes --reload-in=all Atom One Light'
alias howto="alias | grep $1"

# Jump to previous directories with `j`
unalias z 2> /dev/null
j() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

howto() {
  alias | grep "$1"
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Load Bash It
[ "$BASH_IT" ] && source "$BASH_IT"/bash_it.sh
