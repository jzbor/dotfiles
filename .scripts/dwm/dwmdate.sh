#!/bin/sh

# Dependencies: cal dunstify xmenu


case $1 in
    1) dunstify -a "$(date)" "$(cal -n 2)" ;;
    2) setsid xclock ;;
	3) (date; echo; echo; cal -n 2) | xmenu ;;
esac
