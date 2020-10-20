#!/bin/sh

get_status () {
    extra="$(extra-tray.sh)"
    [ -z "$extra" ] || extra="$extra | "
    music.sh has-player && music="$(music.sh status-small) | "
    printf "$extra\x02$music\x03$(volume.sh)% |\x04 $(ethernet.sh) $(wifi.sh) $(bluetooth.sh) |\x05  $(date +%R) ||"
}

kill -9 $(pgrep $(basename $0) | grep -v $$) 2> /dev/null
while true; do
    xsetroot -name "$(get_status)"
    sleep 2 2> /dev/null
done

