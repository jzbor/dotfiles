#!/bin/sh

temp_file="/tmp/weather.txt"

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
    weather="$(curl -s wttr.in/Haar?format="%C+%t")"
    if [ "$weather" != "" ]; then
	echo "$weather" > $temp_file
	echo "$weather"
    else
	if [ -f $temp_file ]; then
	    cat $temp_file
	else
	    echo "N/A"
	fi
    fi
fi
