#!/bin/sh

terminal_label="   Terminal"
vim_label="   Vim"
idea_label="   IDEA"
android_label="   Android Studio"

project="$(ls ~/Programming/*/* -d -t | \
    sed "s/$(echo $HOME | sed 's/\//\\\//g')/~/" | \
    rofi -dmenu -i -p Projects | \
    sed "s/~/$(echo $HOME | sed 's/\//\\\//g')/")"

if [ -z "$project" ]; then
    exit 0
fi

action="$(printf "%s\n%s\n%s\n%s\n" "$terminal_label" "$vim_label" "$idea_label" "$android_label" | \
    rofi -dmenu -i -p "Open with")"
echo $project $action

case $action in
    "$terminal_label")
	case $TERMINAL in
	    "kitty")
		kitty -d "$project"
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
