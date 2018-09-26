#!/bin/sh
export DISPLAY=:0
compton -c -r 5 -o 0.50 -l -5 -t -5 &
sxhkd &
xsetroot -cursor_name left_ptr &
redshift &
sh $HOME/.fehbg &
bspwm
