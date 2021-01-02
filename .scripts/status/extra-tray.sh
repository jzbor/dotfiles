#!/bin/sh
# Check dependencies
DEPENDENCIES="pamixer setxkbmap"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


tray=""

[ -f /tmp/.do-not-disturb ] && tray="$tray ﮖ"
pamixer --default-source --get-mute > /dev/null && tray="$tray "

layout="$(setxkbmap -query | grep '^layout:' | sed 's/.* //')"
[ "$layout" != de ] && tray="$tray [$layout]"

echo $tray
