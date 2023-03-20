function bg_func
  fish -c (string join -- ' ' (string escape -- $argv)) &
end
