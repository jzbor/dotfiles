#!/bin/sh
# Dependencies: pamixer

tray=""

[ -f /tmp/.do-not-disturb ] && tray="$tray ﮖ"
pamixer --default-source --get-mute > /dev/null && tray="$tray "
xset q | grep 'Caps Lock:\s*on' > /dev/null && tray="$tray 祝"

echo $tray
