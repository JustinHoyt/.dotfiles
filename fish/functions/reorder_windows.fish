#! /usr/bin/env fish

function reorder_windows
    set -l i 1
    set -l current_win_id (tmux display-message -p "#I");

    tmux list-windows -F '#I' | while read -l win_id
        [ $win_id -ne $i ] && tmux move-window -s $win_id -t $i
        set i (math $i+1)
    end

    tmux select-window -t $current_win_id
end

