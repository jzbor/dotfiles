#!/bin/sh

# The famous "get a menu of emojis to copy" script.
#   forked from lukesmithxyz/voidrice

UNICODE_FILE="$HOME/.config/resources/unicode.txt"

# Must have xclip installed to even show menu.
xclip -h 2>/dev/null || exit 1

chosen=$(cut -d ';' -f1 "$UNICODE_FILE" | dmenu -i -l 20 | sed "s/ .*//")

[ "$chosen" != "" ] || exit

# If you run this command with an argument, it will automatically insert the character.
if [ -n "$1" ]; then
	xdotool key Shift+Insert
else
	echo "$chosen" | tr -d '\n' | xclip -selection clipboard
	notify-send "'$chosen' copied to clipboard." &
fi
