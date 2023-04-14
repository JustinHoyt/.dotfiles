#! /usr/bin/env fish

function bg_func
  fish -c (string join -- ' ' (string escape -- $argv)) &
end

if test (status current-command) = 'fish'
    if ! isatty stdin; read argv; end
    bg_func $argv
end
