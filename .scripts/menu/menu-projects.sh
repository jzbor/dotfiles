#!/bin/sh
# Check dependencies
DEPENDENCIES="mydmenu"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


terminal_label="   Terminal"
vim_label="   Vim"
idea_label="   IDEA"
android_label="   Android Studio"

project="$(ls ~/Programming/*/* -d -t | \
    sed "s/$(echo $HOME | sed 's/\//\\\//g')/~/" | \
    mydmenu -i -p Projects -l 10 | \
    sed "s/~/$(echo $HOME | sed 's/\//\\\//g')/")"

if [ -z "$project" ]; then
    exit 0
fi

action="$(printf "%s\n%s\n%s\n%s\n" "$terminal_label" "$vim_label" "$idea_label" "$android_label" | \
    mydmenu -i -p "Open with" -l 10)"
echo $project $action

case $action in
    "$terminal_label")
	case $TERMINAL in
	    "kitty")
		kitty -d "$project"
		;;
	    "alacritty")
		alacritty --working-directory "$project"
		;;
	esac
	;;
    "$vim_label")
	$TERMINAL -e nvim "$project" -c ":cd $project"
	;;
    "$idea_label")
	idea "$project"
	;;
    "$android_label")
	android-studio "$project"
	;;
esac
