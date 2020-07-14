#!/bin/sh

get_status () {
    echo "$(music.sh) |  $(pamixer --get-volume)% |  $(date +%R) ||"
}

kill -9 $(pgrep $(basename $0) | grep -v $$) 2> /dev/null
while true; do
    xsetroot -name "$(get_status)"
    sleep 0.3
done
