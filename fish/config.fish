#! /usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    if ! type -q fisher
        curl -sL https://git.io/fisher | source && fisher update
    end

    abbr v nvim
    abbr b --set-cursor "bash -c '%'"
    # Installation command for pkgsrc
    abbr pkgi "sudo (which bmake) install clean clean-depends"
    abbr --set-cursor whi --position anywhere "$(string join \n -- 'while read line' '% $line' 'end')"
    abbr --set-cursor psb --position anywhere "(echo '%' | psub)"
    abbr --set-cursor jqf --position anywhere "jq . (echo '%' | psub)"

    function vdark
        sed -i "s/vim.o.background='light'/vim.o.background='dark'/" ~/.config/nvim/init.lua
    end
    function vlight
        sed -i "s/vim.o.background='dark'/vim.o.background='light'/" ~/.config/nvim/init.lua
    end

    set -g fish_escape_delay_ms 10

    fish_add_path ~/.local/bin

    source ~/.config/fish/config.local.fish

    fzf_configure_bindings --history=\co --directory=\cf --git_status=\cs
end
