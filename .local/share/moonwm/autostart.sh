#!/bin/sh

dunst.sh
music.sh loop &
if [ "$REGULAR_PICOM" = 1 ]; then
    picom --experimental-backends --config ~/.config/picom-basic.conf
else
    (killall -9 picom-guardian.sh; picom-guardian.sh) &
fi
dwmstatus.sh &
command -v rambox > /dev/null && rambox
