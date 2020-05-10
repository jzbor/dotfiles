#!/bin/bash

for terminal in "$TERMINAL" xfce4-terminal alacritty  kitty uxterm xterm x-terminal-emulator urxvt rxvt termit terminator Eterm aterm gnome-terminal roxterm termite lxterminal mate-terminal terminology st qterminal lilyterm tilix terminix konsole guake tilda hyper; do
    if command -v "$terminal" > /dev/null 2>&1; then
	exec "$terminal" "$@"
    fi
done

dunstify -a Terminal "There was no compatible terminal found"
