#!/bin/sh
# Check dependencies
DEPENDENCIES="rofi xdotool"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


rofi -show window -config ~/.config/rofi/windows.rasi &
xdotool mousemove --polar 180 1000000 --sync
xdotool mousemove_relative --polar 0 100
