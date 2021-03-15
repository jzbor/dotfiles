#!/bin/sh
# Dependencies: rofi xdotool


rofi -show window -config ~/.config/rofi/windows.rasi &
xdotool mousemove --polar 180 1000000 --sync
xdotool mousemove_relative --polar 0 100
