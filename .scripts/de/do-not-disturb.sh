#!/bin/sh

# Check dependencies
DEPENDENCIES="killall dunst"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


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

