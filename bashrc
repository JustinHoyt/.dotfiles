# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

[[ $- == *i* ]] && source ~/.ble.sh/out/ble.sh --noattach

export VISUAL=nvim
export EDITOR="$VISUAL"

force_color_prompt=yes

bind 'set completion-ignore-case on'

alias v='nvim'
alias gaa='git add --all'
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

if [ -d ~/.local/share/junest ]; then
  export PATH="~/.local/share/junest/bin:$PATH"
  export PATH="$PATH:~/.junest/usr/bin_wrappers"
  [[ ~/.junest/usr/share/z/z.sh ]] && source ~/.junest/usr/share/z/z.sh
fi

set -o vi

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
[ -f ~/.colors.sh ] && source ~/.colors.sh

# This Changes The PS1
export PROMPT_COMMAND=__prompt_command      # Func to gen PS1 after CMDs
function __prompt_command() {
    exit_code=$?
    prompt_char=$([ "${exit_code}" -eq 0 ] && echo "${green}\$" || echo "${red}\$")
    code_prompt=$([ "${exit_code}" -gt 0 ] && echo " ${red}${exit_code}")
    PS1="\u@\h ${blue}\w ${yellow}[\T]${red}${code_prompt} ${purple}\$([ \j -gt 0 ] && echo {\j})\n${prompt_char} "
}


[[ ${BLE_VERSION-} ]] && ble-attach
