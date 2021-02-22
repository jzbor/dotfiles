#!/bin/sh

keyboard.sh us
dunst.sh
music.sh loop &
(killall -9 picom-guardian.sh; picom-guardian.sh) &
dwmstatus.sh &
