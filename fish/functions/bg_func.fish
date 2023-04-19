#! /usr/bin/env fish

function bg_func
  fish -c (string join -- ' ' (string escape -- $argv)) &
end

if not string match -q -- "*from sourcing file*" (status)
    if ! isatty stdin; read argv; end
    bg_func $argv
end
