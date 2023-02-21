shopt -s checkwinsize

_polus-preexec() {
	local __="$1"; [ -n "$_TOK" ] && unset _TOK && _STIME=$SECONDS; : "$__"
}

d_trap=$(trap -p DEBUG|cut -d\' -f2)
if [ -z "$d_trap" ]; then
	trap '_polus-preexec "$_"' DEBUG
elif [[ "$d_trap" != '_polus-preexec "$_"' ]] && [[ "$d_trap" != '_polus-prea "$_"' ]]; then
	_polus-prea() {
		local __="$1"; $d_trap; _polus-preexec; : "$__"
	}
	trap '_polus-prea "$_"' DEBUG
fi

csr() {
	[ $1 -eq 3600 ] && printf "%dh" $[$1/3600] && return
	[ $1 -gt 3600 ] && printf "%dh" $[$1/3600]
	[ $1 -eq 60 ] && printf "%dm" $[$1%3600/60] && return
	[ $1 -ge 60 ] && printf "%dm" $[$1%3600/60]
	printf "%ds\n" $[$1%60]
}

nwln() {
	local C
	printf "\E[6n"
	read -sdR C
	C=${C#*[}
	C="${C##*;}"
	[ "$C" -ne 1 ] && printf '\n' || return 0
}

__prompt() {
	local EXIT_STATUS=$?
	nwln
	_DURATION=$[SECONDS - _STIME]
	unset _STIME
	_TOK=1
	local MAIN_COLOR=35
	local RESET="\[\e[0m\]"
	local FG="\[\e[1;38;5;16m\]"
	local PROMPT_START=""
	local SEGMENT_SEPARATOR=""
	local FOLDER_ICON=" "
	[ $_DURATION -gt 2 ] && local _TOOK="$(printf "\001\033[1;33m\002%*s\001\033[0m\002" $COLUMNS "took `csr $_DURATION`")\n"
	[ $UID -eq 0 ] && MAIN_COLOR=32
	[ $EXIT_STATUS -ne 0 ] && MAIN_COLOR=196
	[ "$PWD" = "$HOME" ] && FOLDER_ICON=" "
	test -w . || FOLDER_ICON=" "
	[[ " ${PATH//:/ } " =~ " $PWD " ]] && FOLDER_ICON=" "
	local GIT_BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null)"
	[ -n "$GIT_BRANCH" ] && {
		[ "$(git rev-parse --is-inside-git-dir 2>/dev/null)" = "true" ] && local GIT_COLOR=230||{
			git diff --no-ext-diff --quiet &>/dev/null|| local GIT_COLOR=211
			git diff --no-ext-diff --cached --quiet &>/dev/null|| local GIT_COLOR=204
		}
		local GITBG="\[\e[48;5;${GIT_COLOR:-15}m\]"
		local GITFG="\[\e[38;5;${GIT_COLOR:-15}m\]"
		local GIT_ICON=" "
		local GIT_SEGMENT="$FG$GIT_ICON$GIT_BRANCH$RESET$GITFG$SEGMENT_SEPARATOR"
	}
	local BG="\[\e[48;5;${MAIN_COLOR}m\]"
	local SEGMENT_SEPARATOR_COLOR="\[\e[38;5;${MAIN_COLOR}m\]"
	PS0="$RESET"
	local JOBS="\j"
	JOBS="${JOBS@P}"
	[ $JOBS -gt 0 ] && {
		local JOBS_ICON=" "
		local JOBS_COLOR=192
		local JOBS_BG="\[\e[48;5;${JOBS_COLOR}m\]"
		local JOBS_SEGMENT_SEPARATOR_COLOR="\[\e[38;5;${JOBS_COLOR}m\]"
		local JOB_SEGMENT="$JOBS_SEGMENT_SEPARATOR_COLOR$PROMPT_START$JOBS_BG$FG$JOBS_ICON$JOBS"
		PROMPT_START=""
	}
	PS1="$RESET$_TOOK$JOB_SEGMENT$SEGMENT_SEPARATOR_COLOR$PROMPT_START$RESET$FG$BG$FOLDER_ICON\w$RESET$SEGMENT_SEPARATOR_COLOR$GITBG$SEGMENT_SEPARATOR$GIT_SEGMENT$RESET "
	eval "$_PRC"
}

_PRC="${PROMPT_COMMAND}"
PROMPT_COMMAND="__prompt"
_STIME=$SECONDS

