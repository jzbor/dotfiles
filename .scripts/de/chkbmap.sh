#! /bin/sh

# Check dependencies
DEPENDENCIES="dunstify sxkbmap"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


german_layout="de"
#german_layout="de -variant querty"

if [ "$1" = "init" ]; then
    setxkbmap $german_layout
    exit
fi

old_layout="$(setxkbmap -query | grep layout | awk '{ print$2 }')"

case $old_layout in
    "de" )
	new_layout="us"
	;;
    "us" | "gb")
	new_layout="$german_layout"
	;;
    *)
	dunstify -a Keyboard "No switching behaviour set for $old_layout"
	exit 1
	;;
esac

dunstify -a Keyboard "$old_layout -> $new_layout"
# The word splitting is intended
setxkbmap $new_layout

