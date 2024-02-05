#! /usr/bin/env fish

function dark
	perl -i -pE 's#(?<=^vim.o.background.{1,100})light#dark#g' ~/.config/nvim/init.lua
    perl -i -pE 's#\*one_light#\*one_dark#' ~/.config/alacritty/alacritty.yml
end

function light
	perl -i -pE 's#(?<=^vim.o.background.{1,100})dark#light#g' ~/.config/nvim/init.lua
    perl -i -pE 's#\*one_dark#\*one_light#' ~/.config/alacritty/alacritty.yml
end

function toggle
    if grep 'colors: \*one_light' ~/.config/alacritty/alacritty.yml > /dev/null
        dark
    else
        light
    end
end

if not string match -q -- "*from sourcing file*" (status)
    if ! isatty stdin; read argv; end
    toggle $argv
end
