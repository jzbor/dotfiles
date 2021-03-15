#!/bin/sh
# Dependencies: alacritty curl dunstify


if [ "$1" = "notify" ]; then
    weather="$(curl -s wttr.in/?0T)"
    if [ "$weather" != "" ]; then
	title="$(echo "$weather" | head -n 1)"
	content="$(echo "$weather" | tail -n +2)"
	dunstify -a "$title" "$content"
    else
	printf "Not available\nPlease try turning on some sort of internet connection"
    fi
else
    location="$(mydmenu -p Location:)"
    alacritty -e "/usr/bin/sh" "-c" "clear; curl \"v2.wttr.in/$location\"; read"
fi
