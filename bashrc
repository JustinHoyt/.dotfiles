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
alias hr='history -r' # reload history

# Jump to previous directories with `j`
unalias z 2> /dev/null
function j() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

function howto() {
  alias | grep "$1"
}

if [ -d ~/.local/share/junest ]; then
  export PATH="~/.local/share/junest/bin:$PATH"
  export PATH="$PATH:~/.junest/usr/bin_wrappers"
  [[ ~/.junest/usr/share/z/z.sh ]] && source ~/.junest/usr/share/z/z.sh
fi

set -o vi

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=10000                    # big history
export HISTFILESIZE=10000                # big history
shopt -s histappend                      # append to history, don't overwrite it

# Remove all duplicates preserving the newest usage of the line
if command -v tac &> /dev/null; then
  new_history=$(tac ~/.bash_history | awk '!line_occurances_map[$0]++' | tac)
  echo "${new_history}" > ~/.bash_history
fi

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
    history -a

    PS1="\u@\h ${blue}\w ${yellow}[\T]${red}${code_prompt} ${purple}\$([ \j -gt 0 ] && echo {\j})\n${prompt_char} "
}

[[ ${BLE_VERSION-} ]] && ble-attach
