#!/bin/sh

# Setup keyboard stuff
xmodmap -e "keycode 29 = z Z z Z"
xmodmap -e "keycode 52 = y Y y Y"
xmodmap -e "keycode 94 = Alt_L Meta_L Alt_L Meta_L"

dunst.sh
music.sh loop &
(killall -9 picom-guardian.sh; picom-guardian.sh) &
dwmstatus.sh &
