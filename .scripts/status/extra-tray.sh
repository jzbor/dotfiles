#!/bin/sh
# Dependencies: pamixer

tray=""

[ -f /tmp/.do-not-disturb ] && tray="$tray ﮖ"
[ "$(< /etc/hostname)" = "pinebook-pro" ] && ! [ -d "/sys/devices/platform/fe3c0000.usb/usb1/1-1/1-1.2" ] && tray="$tray 﫞"
pamixer --default-source --get-mute > /dev/null && tray="$tray "
xset q | grep 'Caps Lock:\s*on' > /dev/null && tray="$tray 祝"

echo $tray
