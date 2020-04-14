#!/bin/sh

kill_pid="$(ps -xo pid=,cmd= | rofi -dmenu -i -p Kill | awk '{ print $1 }')"

if [ -n "$kill_pid" ]; then
    kill -n 9 "$kill_pid"
    dunstify -a "Process killed" "Successfully terminated process with pid $kill_pid"
fi
