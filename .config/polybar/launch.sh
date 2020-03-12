#!/usr/bin/env bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(xrandr | grep ' connected ' | cut --delimiter=' ' --fields=1); do
    MONITOR=$m
    export MONITOR
    polybar -c "$HOME/.config/polybar/bars" main &
done

sleep 0.5

#xdo lower -n polybar

