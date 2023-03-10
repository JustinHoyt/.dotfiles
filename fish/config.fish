#! /usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    if ! type -q fisher
        curl -sL https://git.io/fisher | source && fisher update
    end

    abbr b "bash -c"

    alias v nvim

    set -g fish_escape_delay_ms 10

    source ~/.config/fish/config.local.fish
end
