#! /usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    if ! type -q fisher
        curl -sL https://git.io/fisher | source && fisher update
    end

    set -g fish_escape_delay_ms 10
    # Add personal y.pm module to Perl's path. Use it with `perl -My`
    set -gx PERL5LIB "$HOME/.local/bin" $PERL5LIB


    abbr v nvim
    abbr b --set-cursor "bash -c '%'"
    abbr apti 'sudo apt install -y'
    # Installation command for pkgsrc
    abbr pkgi "sudo (which bmake) install clean clean-depends"
    abbr --set-cursor whi --position anywhere "$(string join \n -- 'while read line' '% $line' 'end')"
    abbr --set-cursor psb --position anywhere "(echo '%' | psub)"
    abbr --set-cursor jqf --position anywhere "jq . (echo '%' | psub)"

    # Perl abbreviations
    abbr --set-cursor pe --position anywhere "perl -My -E 'say %'"
    abbr --set-cursor pp --position anywhere "perl -My -pE '%'"
    abbr --set-cursor pn --position anywhere "perl -My -nE '%'"
    abbr --set-cursor pnp --position anywhere "perl -My -nE 'print if /%/g'"
    # Show before and after of a Substitute
    abbr --set-cursor pa --position anywhere "perl -My -aE 'say %'"
    abbr --set-cursor pfc --position anywhere "perl -My -F',' -E 'say % @F'"
    # Field separator as newline, Record separator as 2 newlines
    abbr --set-cursor pfn --position anywhere "perl -My -00 -F'\n' -E 'say % @F'"
    abbr --set-cursor pft --position anywhere "perl -My -F'\t' -E 'say % @F'"
    # Record separator as space
    abbr --set-cursor pos --position anywhere "perl -My -040 -nE 'print %'"
    # Record separator as 2 newlines
    abbr --set-cursor poo --position anywhere "perl -My -00 -nE 'print %'"

    function vdark
        sed -i "s/vim.o.background='light'/vim.o.background='dark'/" ~/.config/nvim/init.lua
    end
    function vlight
        sed -i "s/vim.o.background='dark'/vim.o.background='light'/" ~/.config/nvim/init.lua
    end

    fish_add_path ~/.local/bin

    source ~/.config/fish/config.local.fish

    fzf_configure_bindings --history=\co --directory=\cf --git_status=\cs
end
