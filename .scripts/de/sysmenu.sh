#!/bin/sh

# @TODO Filter out names at the beginning before piping to bash
sed 's/ |.*//g' < "$HOME"/.config/rofi/sysmenu.txt | \
    rofi -dmenu -i -p "System" | \
    xargs -I {} grep "{}" "$HOME"/.config/rofi/sysmenu.txt | \
    /bin/bash
