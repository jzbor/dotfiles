#!/bin/sh
# Check dependencies
DEPENDENCIES="dunstify picom"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


killall -9 picom; picom --experimental-backends 2> ~/.cache/picom.log

while ! picom --experimental-backends 2> ~/.cache/picom.log; do
    echo "Picom seems to have crashed; Restarting picom..."
    dunstify -a "Picom Guardian" "Picom seems to have crashed; Restarting picom..."
	cp ~/.cache/picom.log ~/.cache/picom.log.old
    sleep 2
done



