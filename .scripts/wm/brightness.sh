#! /bin/sh

if [ "$1" = "toggle" ] || [ "$1" = "t" ]; then
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
fi
