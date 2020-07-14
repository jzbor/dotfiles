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
    "-inc" | "inc" | "+")
	light -A $2
	;;
    "-dec" | "dec" | "-")
	light -U $2
	;;
    "-set" | "set" | "=")
	light -S $2
	;;
    "-get" | "get")
	light -G $2
	;;
    "")
	;;
    *)
	light $@
	;;
esac

dunstify -a Brightness -r $DUNST_ID "Set brightness to $(light | sed 's/\..*//g')%"
