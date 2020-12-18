#!/bin/sh

# Check dependencies
DEPENDENCIES="dunstify ffplay scrot"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


! [ -d "$HOME/Pictures/Screenshots/" ] && mkdir -p "$HOME/Pictures/Screenshots/"

filename="$(date +'Screenshot_%Y-%m-%d_%H-%M-%S.png')"

case "$1" in
    "" | select)
		if scrot -s -f "$filename" \
				-e 'mv -f $f ~/Pictures/Screenshots/'; then
			ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/screen-capture.oga
			dunstify -a Scrot -i ~/Pictures/Screenshots/$filename "Sucessfully taken screenshot" \
				--action "$FILEBROWSER ~/Pictures/Screenshots/,open in filebrowser" \
				--action "phone --share ~/Pictures/Screenshots/$filename,send to phone" \
				--action "xdg-open ~/Pictures/Screenshots/$filename,open in viewer" \
				--action "gimp ~/Pictures/Screenshots/$filename,edit in gimp" \
				| sh
		fi
		;;
    focused)
		if scrot -u "$filename" \
				-e 'mv -f $f ~/Pictures/Screenshots/'; then
			ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/screen-capture.oga
			dunstify -a Scrot -i ~/Pictures/Screenshots/$filename "Sucessfully taken screenshot" \
				--action "$FILEBROWSER ~/Pictures/Screenshots/,open in filebrowser" \
				--action "phone --share ~/Pictures/Screenshots/$filename,send to phone" \
				--action "xdg-open ~/Pictures/Screenshots/$filename,open in viewer" \
				--action "gimp ~/Pictures/Screenshots/$filename,edit in gimp" \
				| sh
		fi
		;;
    screen)
		if scrot "$filename" \
				-e 'mv -f $f ~/Pictures/Screenshots/'; then
			ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/screen-capture.oga
			dunstify -a Scrot -i ~/Pictures/Screenshots/$filename "Sucessfully taken screenshot" \
				--action "$FILEBROWSER ~/Pictures/Screenshots/,open in filebrowser" \
				--action "phone --share ~/Pictures/Screenshots/$filename,send to phone" \
				--action "xdg-open ~/Pictures/Screenshots/$filename,open in viewer" \
				--action "gimp ~/Pictures/Screenshots/$filename,edit in gimp" \
				| sh
		fi
		;;
esac
