#! /usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    if ! type -q fisher
        curl -sL https://git.io/fisher | source && fisher update
    end

    set -g fish_escape_delay_ms 10
    # Add personal y.pm module to Perl's path. Use it with `perl -My`
    set -l dir_to_add $HOME/.local/bin
    if not contains $dir_to_add (string split ":" $PERL5LIB)
        set -gx PERL5LIB "$dir_to_add":"$PERL5LIB"
    end

    abbr v nvim
    abbr caffeine 'caffeinate -imdsu'
    abbr b --set-cursor "bash -c '%'"
    abbr apti 'sudo apt install -y'
    # Sync histories with other open fish shells
    abbr hm 'history merge'
    # Installation command for pkgsrc
    abbr pkgi "sudo (which bmake) install clean clean-depends"
    abbr --set-cursor whi --position anywhere "$(string join \n -- 'while read line' '% $line' 'end')"
    abbr --set-cursor psb --position anywhere "(echo '%' | psub)"
    abbr --set-cursor cpy --position anywhere "| tty-copy"
    abbr --set-cursor jqf --position anywhere "jq . (echo '%' | psub)"
    abbr --set-cursor ent --position anywhere "| entr -c -r"

    # Perl abbreviations
    abbr --set-cursor pe --position anywhere "perl -E 'say %'"
    abbr --set-cursor pp --position anywhere "perl -pE '%'"
    abbr --set-cursor pn --position anywhere "perl -nE '%'"
    abbr --set-cursor pnp --position anywhere "perl -nE 'print if m#%#g'"
    abbr --set-cursor pnu --position anywhere "perl -nE 'print unless m#%#g'"
    # Find files
    abbr --set-cursor pef "perl -My -E 'find(sub { say if m#%# }, \".\")'"
    # Show before and after of a Substitute
    abbr --set-cursor pa --position anywhere "perl -aE 'say %'"
    # Field separator as newline, Record separator as a comma
    abbr --set-cursor pfc --position anywhere "perl -F',' -E 'say % @F'"
    # Field separator as newline, Record separator as 2 newlines
    abbr --set-cursor pfn --position anywhere "perl -00 -F'\n' -E 'say % @F'"
    # Field separator as newline, Record separator as a tab
    abbr --set-cursor pft --position anywhere "perl -F'\t' -E 'say % @F'"
    # Record separator as space
    abbr --set-cursor p04 --position anywhere "perl -040 -nE 'print %'"
    # Record separator as 2 newlines
    abbr --set-cursor p00 --position anywhere "perl -00 -nE 'print %'"
    # Slurp whole file into one record
    abbr --set-cursor p07 --position anywhere "perl -0777 -nE 'print %'"
    # Find and Replace
    abbr --set-cursor pr --position anywhere "perl -i -pE 's#%#&#g'"
    # Find and Replace preview
    abbr --set-cursor prv --position anywhere "ppr 's#%#\$&#g'"

    fish_add_path ~/.local/bin

    if type -q perl
        set -x PATH "$HOME/perl5/bin:$PATH"
        set -x PERL5LIB "$HOME/perl5/lib/perl5:$PERL5LIB"
        set -x PERL_LOCAL_LIB_ROOT "$HOME/perl5:$PERL_LOCAL_LIB_ROOT"
        set -x PERL_MB_OPT "--install_base \"$HOME/perl5\""
        set -x PERL_MM_OPT "INSTALL_BASE=$HOME/perl5"
    end

    set -x EDITOR "nvim"

    source ~/.config/fish/config.local.fish

    fzf_configure_bindings --history=\cy --directory=\cf --git_status=\cs
end
