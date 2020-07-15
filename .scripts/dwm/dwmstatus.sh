#!/bin/sh

get_status () {
    printf "$(music.sh) |\x02 $(volume.sh)% |\x03 $(ethernet.sh) $(wifi.sh) $(bluetooth.sh) |\x04  $(date +%R) ||"
}

kill -9 $(pgrep $(basename $0) | grep -v $$) 2> /dev/null
while true; do
    xsetroot -name "$(get_status)"
    sleep 2 2> /dev/null
done

