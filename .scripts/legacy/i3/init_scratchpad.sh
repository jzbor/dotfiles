#!/bin/sh

### DEPRECATED ###

if command -v alacritty; then
    nice -n 9 alacritty -t scratchterm &
    nice -n -8 alacritty -t taskmgr -e htop &
    echo "Starting scratchpad with alacritty"
elif command -v kitty; then
    nice -n -9 kitty -T scratchterm &
    nice -n -8 kitty -T taskmgr -e htop &
    echo "Starting scratchpad with kitty"
fi
