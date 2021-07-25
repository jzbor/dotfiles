#!/bin/sh

device="$(xsetwacom --list devices | dmenu -l 10 -p "Select device" | sed 's/ *\t.*//')"
[ -z "$device" ] && exit
output="$(xrandr | grep ' connected ' | sed 's/ (.*//' | \
    dmenu -l 10 -p "Select monitor to map to" | cut -d' ' -f1)"
[ -z "$output" ] && exit

xsetwacom --set "$device" MapToOutput "$output"

notify-send -a "Wacom Tablet" "Mapping $device to $output"
