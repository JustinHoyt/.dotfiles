# Print and graph with a preceeding newline
abbr hxln 'printf \'\n\' && hg xl'

abbr hml 'hmail -t %'

abbr hab 'hg absorb'

abbr ha 'hg add'

abbr har 'hg addremove'
abbr harc 'hg addremove; hg commit'
abbr harcd 'hg addremove; hg commit --addremove --message "Update personal g3docs"; hg fix; hg upload chain; sub; hg sync'
abbr harcs 'hg addremove; hg commit --addremove --message "Update personal scripts"; hg fix; hg upload chain; sub; hg sync'

abbr ham 'hg amend'
abbr hae 'hg amend; hg evolve'
abbr haex 'hg amend; hg export'
abbr hauc 'hg amend; hg upload chain'
abbr haucpsh 'hg amend; hg upload chain; presub && hml'

abbr hrmcl 'hg cls-setnumber --remove -c \'extinct() & exportedchange()\''

abbr hc 'hg commit'
abbr hca 'hg commit --amend'
abbr hcm --set-cursor 'hg commit --message "%"'

abbr hct 'hg continue'

abbr hd 'hg diff'
abbr hdn 'hg diff % | nvim'
abbr hdp 'hg diff --pager always'

abbr hev 'hg evolve'
abbr heva 'hg evolve --abort'
abbr hevc 'hg evolve --continue'

abbr hex 'hg export'

abbr hf 'hg fix'

# hg all
abbr haa 'hg fix; tricorder analyze -fix -categories Lint; hg fix; build_cleaner_all; hg amend'
abbr hauc 'hg fix; tricorder analyze -fix -categories Lint; hg fix; build_cleaner_all; hg amend; hg upload chain'
abbr haps 'hg fix; tricorder analyze -fix -categories Lint; hg fix; build_cleaner_all; hg amend; hg upload chain; presub'
abbr haml 'hg fix; tricorder analyze -fix -categories Lint; hg fix; build_cleaner_all; hg amend; hg upload chain; presub; hml'

abbr hhe 'hg histedit'
abbr hhea 'hg histedit --abort'
abbr hhec 'hg histedit --continue'

abbr hls 'hg l --stat --noninteractive'
abbr hlscl 'hg l | string match "*$USER cl/*" | string collect | read x; echo $x'

abbr hne 'hg next'
abbr hnee 'hg next && hg next'
abbr hneee 'hg next && hg next && hg next'
abbr hneeee 'hg next && hg next && hg next && hg next'
abbr hpr 'hg prev'
abbr hprr 'hg prev && hg prev'
abbr hprrr 'hg prev && hg prev && hg prev'
abbr hprrrr 'hg prev && hg prev && hg prev && hg prev'

abbr hrb 'hg rebase;'
abbr hrba 'hg rebase --abort'
abbr hrbc 'hg rebase --continue'

abbr hma 'hg resolve --mark --all'

abbr hra 'hg revert --all'

abbr hsh 'hg shelve'

abbr hsp 'hg split'

abbr hs 'hg status && hxln'
abbr hsn 'hg status --no-status --color false --noninteractive'
abbr hsm 'hg status | perl -lane \'print $1 if /^M (.*)/\''
abbr hss '{ hg stat --change .; hg status; } | perl -lane \'print @F[1]\''

abbr hsb 'hg submit'

abbr hsy 'hg sync'

abbr hucnk 'hg uncommit --no-keep'

abbr hush 'hg unshelve'
abbr hushc 'hg unshelve --continue'
abbr husha 'hg unshelve --abort'

abbr hup 'hg update'
abbr hupt 'hg update tip'

abbr huc 'hg upload chain'

abbr hxl 'hg xl'
