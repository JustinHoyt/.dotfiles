#! usr/bin/env fish

function gg
  git log --graph --all --pretty=format:'%C(bold)%h%Creset%C(auto)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative $argv
end

function get_default_branch
  git remote show origin | sed -n '/HEAD branch/s/.*: //p'
end

function gs
  git fetch
  set main (get_default_branch)
  set num_commits (git rev-list --count  origin/"$main"..."$main")
  set num_commits_to_show (math max $num_commits,5)
  echo "" && git status -s &&  echo "" && gg HEAD~$num_commits_to_show...@{upstream}
end
