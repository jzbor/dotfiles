#!/bin/sh

! [ -d "$HOME/Pictures/Screenshots/" ] && mkdir -p "$HOME/Pictures/Screenshots/"

case "$1" in
    "" | select)
	scrot -s -f 'Screenshot_%Y-%m-%d_%H-%M-%S.png' \
	    -e 'mv -f $f ~/Pictures/Screenshots/ && dunstify -a Scrot -i ~/Pictures/Screenshots/$f "Sucessfully taken screenshot"'
	;;
    focused)
	scrot -u 'Screenshot_%Y-%m-%d_%H-%M-%S.png' \
	    -e 'mv -f $f ~/Pictures/Screenshots/ && dunstify -a Scrot -i ~/Pictures/Screenshots/$f "Sucessfully taken screenshot"'
	;;
    screen)
	scrot 'Screenshot_%Y-%m-%d_%H-%M-%S.png' \
	    -e 'mv -f $f ~/Pictures/Screenshots/ && dunstify -a Scrot -i ~/Pictures/Screenshots/$f "Sucessfully taken screenshot"'
	;;
esac
