#!/bin/sh
# Dependencies: pamixer


tray=""

[ -f /tmp/.do-not-disturb ] && tray="$tray ﮖ"
pamixer --default-source --get-mute > /dev/null && tray="$tray "

echo $tray
