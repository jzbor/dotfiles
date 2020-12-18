#!/bin/sh

# Check dependencies
DEPENDENCIES="cal dunstify xmenu"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


case $1 in
    1) dunstify -a "$(date)" "$(cal -n 2)" ;;
    2) setsid xclock ;;
	3) (date; echo; echo; cal -n 2) | xmenu ;;
esac
