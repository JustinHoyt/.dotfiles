#! /usr/bin/env fish

function fzf_select_from_rerun_command_output
    set cmd (history | fzf --header "Choose the command to rerun.")
    if test -n "$cmd"
            set result (eval $cmd | fzf -m --sync --bind start:last+select-all --header "Choose the line(s) from the repeated command\'s output to paste into the current command-line. (The order matters!)")
            if test -n "$result"
                    commandline -i (string join " " -- $result "") # adds a space after the inserted line output
                end
        end
    commandline -f repaint
end

