#!/bin/sh

killall picom; picom --experimental-backends 2> ~/.cache/picom.log

while ! picom --experimental-backends 2> ~/.cache/picom.log; do
    echo "Picom seems to have crashed; Restarting picom..."
    dunstify -a "Picom Guardian" "Picom seems to have crashed; Restarting picom..."
    sleep 2
done



