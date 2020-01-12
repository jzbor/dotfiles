#!/usr/bin/env bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


# Launch bar1 and bar2
polybar -c ~/.config/polybar/bars main &
polybar -c ~/.config/polybar/bars sec &

sleep 0.5

#xdo lower -n polybar

