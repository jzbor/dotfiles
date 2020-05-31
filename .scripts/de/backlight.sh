#! /bin/sh

DUNST_ID=9170

case $1 in
    toggle | t)
	echo pass
	current="$(xbacklight | sed 's/\..*//g')"
	case "$current" in
	    "19" | "20")
		xbacklight -set 80
		;;
	    "79" | "80")
		xbacklight -set 100
		;;
	    "99" | "100")
		xbacklight -set 20
		;;
	    *)
		xbacklight -set 80
		;;
	esac
	;;
    "")
	;;
    *)
	xbacklight $@
	;;
esac

dunstify -a Brightness -r $DUNST_ID "Set brightness to $(xbacklight | sed 's/\..*//g')%"
