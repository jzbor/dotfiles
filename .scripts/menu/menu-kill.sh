#!/bin/sh
# Dependencies: dunstify ps xprop dmenu


if [ "$1" = "visual" ]; then
    kill_pid="$(xprop _NET_WM_PID | cut -d' ' -f3)"
    echo $kill_pid | grep "^[0-9]*$" > /dev/null 2>&1 || exit
    kill_name="$(ps axo pid,args | grep "^$kill_pid " | cut -d' ' -f2)"
    input="$(printf "Kill $kill_pid ($kill_name)?\n\nYes\nNo\n" | xmenu)"
    [ "$input" != "Yes" ] && exit
else
    kill_pid="$(ps -xo pid=,cmd= | dmenu -i -p Kill -l 10 | awk '{ print $1 }')"
    kill_name="$(ps axo pid,args | grep "^$kill_pid " | cut -d' ' -f2)"
fi

if [ -n "$kill_pid" ]; then
    kill -n 9 "$kill_pid"
    dunstify -a "Process killed" "Successfully terminated process $kill_pid ($kill_name)."
fi
