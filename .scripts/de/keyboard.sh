#! /bin/sh

# Check dependencies
DEPENDENCIES="dunstify setxkbmap"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


options="-option -option caps:escape_shifted_capslock -option lv3:ralt_alt"
default_layout="us"

set_layout () {
    case $1 in
        de)
            setxkbmap de nodeadkeys $options -option lv3:lwin_switch
            ;;
        us | us,de)
            setxkbmap us,de $options -option eurosign:e -option grp:lwin_switch
            xmodmap -e "keycode 29 = z Z z Z"
            xmodmap -e "keycode 52 = y Y y Y"
            ;;
    esac
}

case $1 in
	"toggle")
		old_layout="$(setxkbmap -query | grep layout | awk '{ print$2 }')"
		case $old_layout in
			"de")
				set_layout us
				;;
			"us" | "gb" | "us,de")
				set_layout de
				;;
			*)
				set_layout "$default_layout"
				;;
		esac
		;;
	"")
		set_layout "$default_layout"
		;;
	*)
        set_layout "$1"
		;;
esac



dwmstatus-update.sh
# dunstify -a Keyboard "$old_layout -> $(echo $new_layout | cut -f1 -d' ') ($?)"

