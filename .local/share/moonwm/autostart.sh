#!/bin/sh

dunst.sh
music.sh loop &
(killall -9 picom-guardian.sh; picom-guardian.sh) &
dwmstatus.sh &
if [ "$(< /etc/hostname)" = T440 ] && killall -2 touchegg; then
    touchegg --daemon 750 750 &
    touchegg &
fi
