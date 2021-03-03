#! /bin/sh
# Check dependencies
DEPENDENCIES="dunstify light"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


DUNST_ID=9170

case $1 in
	"-i" | "-inc" | "inc" | "+")
		light -A $2
		;;
	"-d" | "-dec" | "dec" | "-")
		light -U $2
		;;
	"-s" | "-set" | "set" | "=")
		light -S $2
		;;
	"-g" | "-get" | "get")
		light -G $2
		;;
	"")
		;;
	*)
		light $@
		;;
esac

dunstify -a Brightness -i "notification-display-brightness" -r $DUNST_ID \
	"Set brightness to $(light | sed 's/\..*//g')%"
