#!/bin/sh
# Check dependencies
DEPENDENCIES="pamixer"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


tray=""

[ -f /tmp/.do-not-disturb ] && tray="$tray ﮖ"
pamixer --default-source --get-mute > /dev/null && tray="$tray "

echo $tray
