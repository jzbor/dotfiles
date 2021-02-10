#!/bin/sh
# Check dependencies
DEPENDENCIES="dunstify ps rofi xprop"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


if [ "$1" = "visual" ]; then
    kill_pid="$(xprop _NET_WM_PID | cut -d' ' -f3)"
    echo $kill_pid | grep "^[0-9]*$" > /dev/null 2>&1 || exit
    kill_name="$(ps axo pid,args | grep "^$kill_pid " | cut -d' ' -f2)"
    input="$(printf "Yes\nNo\n" | rofi -dmenu -i -p "Kill $kill_pid ($kill_name)?")"
    [ "$input" != "Yes" ] && exit
else
    kill_pid="$(ps -xo pid=,cmd= | rofi -dmenu -i -p Kill | awk '{ print $1 }')"
    kill_name="$(ps axo pid,args | grep "^$kill_pid " | cut -d' ' -f2)"
fi

if [ -n "$kill_pid" ]; then
    kill -n 9 "$kill_pid"
    dunstify -a "Process killed" "Successfully terminated process $kill_pid ($kill_name)."
fi
