#! /usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    if ! type -q fisher
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    end

    abbr b "bash -c"

    alias v nvim

    set -g fish_escape_delay_ms 10

    source ~/.config/fish/config.local.fish

    function fish_user_key_bindings
        fish_vi_key_bindings
        bind -e --mode default --user \eh
        bind -e --mode default --user \ew
        bind -e --mode default --user \eb
        bind -e --mode default --user \e0
        bind -e --mode default --user \ek
        bind -e --mode default --user \ej
        bind -e --mode default --user \el
        bind -e --mode default --user \ed

        bind -e --mode default --preset \eh
        bind -e --mode default --preset \ew
        bind -e --mode default --preset \eb
        bind -e --mode default --preset \e0
        bind -e --mode default --preset \ek
        bind -e --mode default --preset \ej
        bind -e --mode default --preset \el
        bind -e --mode default --preset \ed

        bind -e --mode visual --user \eh
        bind -e --mode visual --user \ew
        bind -e --mode visual --user \eb
        bind -e --mode visual --user \e0
        bind -e --mode visual --user \ek
        bind -e --mode visual --user \ej
        bind -e --mode visual --user \el
        bind -e --mode visual --user \ed

        bind -e --mode visual --preset \eh
        bind -e --mode visual --preset \ew
        bind -e --mode visual --preset \eb
        bind -e --mode visual --preset \e0
        bind -e --mode visual --preset \ek
        bind -e --mode visual --preset \ej
        bind -e --mode visual --preset \el
        bind -e --mode visual --preset \ed

        bind -e --mode insert --user \eh
        bind -e --mode insert --user \ew
        bind -e --mode insert --user \eb
        bind -e --mode insert --user \e0
        bind -e --mode insert --user \ek
        bind -e --mode insert --user \ej
        bind -e --mode insert --user \el
        bind -e --mode insert --user \ed

        bind -e --mode insert --preset \eh
        bind -e --mode insert --preset \ew
        bind -e --mode insert --preset \eb
        bind -e --mode insert --preset \e0
        bind -e --mode insert --preset \ek
        bind -e --mode insert --preset \ej
        bind -e --mode insert --preset \el
        bind -e --mode insert --preset \ed
    end
end
