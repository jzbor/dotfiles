#! /bin/sh

old_layout="$(setxkbmap -query | grep layout | awk '{ print$2 }')"

case $old_layout in
    "de" )
	new_layout="us"
	;;
    "us" | "gb")
	new_layout="de"
	;;
    *)
	dunstify -a Keyboard "No switching behaviour set for $old_layout"
	;;
esac

dunstify -a Keyboard "$old_layout -> $new_layout"
setxkbmap $new_layout

