#!/bin/sh
# The famous "get a menu of emojis to copy" script.
#   forked from lukesmithxyz/voidrice

UNICODE_FILE="$HOME/.config/assets/menu/unicode.txt"

# Must have xclip installed to even show menu.
xclip -h 2>/dev/null || exit 1

chosen=$(cut -d ';' -f1 "$UNICODE_FILE" | rofi -dmenu -i -l 20 -p "Unicode" | sed "s/ .*//")

[ "$chosen" != "" ] || exit

# If you run this command with an argument, it will automatically insert the character.
if [ -n "$1" ]; then
    xdotool type --delay 1000 "$chosen"

    # A hacky way to ensure compatibility with WhatsApp Web
    xdotool search --name WhatsApp key Left
    xdotool search --name WhatsApp key BackSpace
    xdotool search --name WhatsApp key BackSpace
    xdotool search --name WhatsApp key Right
else
    echo "$chosen" | tr -d '\n' | xclip -selection clipboard
    dunstify "'$chosen' copied to clipboard." &
fi
