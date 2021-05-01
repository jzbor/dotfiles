#!/bin/sh

dunst.sh
music.sh loop &
(killall -9 picom-guardian.sh; picom-guardian.sh) &
dwmstatus.sh &
command -v rambox > /dev/null && rambox
