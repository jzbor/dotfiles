#! /bin/sh

# Check dependencies
DEPENDENCIES="dunstify setxkbmap"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


options="-option -option caps:escape_shifted_capslock -option lv3:ralt_alt -option lv3:lwin_switch"

set_layout () {
	case $1 in
		de)
			setxkbmap de nodeadkeys $options
			;;
		us)
			setxkbmap us $options
			xmodmap -e "keycode 29 = z Z z Z"
			xmodmap -e "keycode 52 = y Y y Y"
			;;
	esac
}

if [ -z "$1" ]; then
	old_layout="$(setxkbmap -query | grep layout | awk '{ print$2 }')"
	case $old_layout in
		"de" )
			set_layout us
			;;
		"us" | "gb")
			set_layout de
			;;
		*)
				set_layout de
			;;
	esac
else
		set_layout "$1"
fi



dwmstatus-update.sh
# dunstify -a Keyboard "$old_layout -> $(echo $new_layout | cut -f1 -d' ') ($?)"

