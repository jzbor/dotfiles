#!/bin/sh

if [ -z "$1" ]; then
    file="$HOME"/.config/rofi/main.txt
else
    file="$HOME"/.config/rofi/"$1".txt
fi

delimiter="|"

tail -n +2 "$file" | sed "s/$delimiter.*//" | \
    rofi -dmenu -i -p "$(eval echo $(head -n 1 "$file"))" | \
    xargs -I {} grep "^{}\s*$delimiter" "$file" | \
    sed "s/^.*$delimiter\s*//" | \
    /bin/bash

