#! /bin/sh

# Check dependencies
DEPENDENCIES="dunstify setxkbmap"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


options="-option -option caps:escape_shifted_capslock -option lv3:ralt_alt -option lv3:lwin_switch"
german_layout="de nodeadkeys"
english_layout="us"

if [ "$1" = "init" ]; then
    setxkbmap $german_layout
    exit
fi

old_layout="$(setxkbmap -query | grep layout | awk '{ print$2 }')"

case $old_layout in
	"de" )
		new_layout="$english_layout $options"
		;;
	"us" | "gb")
		new_layout="$german_layout $options"
		;;
	*)
		# dunstify -a Keyboard "No switching behaviour set for $old_layout.\nUsing de as fallback."
		new_layout="$german_layout $options"
		;;
esac

# The word splitting is intended
setxkbmap $new_layout
dwmstatus-update.sh
# dunstify -a Keyboard "$old_layout -> $(echo $new_layout | cut -f1 -d' ') ($?)"

