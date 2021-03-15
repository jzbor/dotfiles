#!/bin/sh

# Dependencies: killall dunst


on () {
    touch /tmp/.do-not-disturb
    killall -SIGUSR1 dunst
}

off () {
    rm /tmp/.do-not-disturb
    killall -SIGUSR2 dunst
}

case $1 in
    on)
	on
	;;
    off)
	off
	;;
    toggle)
	if [ -f /tmp/.do-not-disturb ]; then
	    off
	else
	    on
	fi
	;;
esac

