#!/bin/sh


if pidof spotify > /dev/null; then
    for wid in $(xdotool search --class spotify | tr '\n' ' '); do
        moonctl activate "$wid"
    done
else
    spotify &
    while [ -z "$xid" ]; do
        for xid in $(xdotool search --class spotify); do
            moonctl activate "$xid" 200 && moonctl tag $((1<<7))
        done
        sleep 0.2
    done
fi
