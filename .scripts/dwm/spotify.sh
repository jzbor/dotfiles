#!/bin/sh


if pidof spotify; then
    moonctl toggleview $((1<<7));
else
    spotify &
    sleep 0.5
    inittags="$(moonctl currenttags)"
    for xid in $(xdotool search --class spotify); do
        moonctl activate "$xid" 200 && moonctl tag $((1<<7))
    done
    moonctl view "$inittags"
fi
