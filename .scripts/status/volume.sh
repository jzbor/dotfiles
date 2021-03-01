#!/bin/sh
# Check dependencies
DEPENDENCIES="dwmstatus.sh ffplay pamixer"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


boost_overwrite_file="/tmp/pa-overwrite-boost"

case $1 in
	"-i" | "--inc" | "inc" | "+")
		if [ -f "$boost_overwrite_file" ]; then
			pamixer -i "${2:-5}" --allow-boost
		else
			pamixer -i "${2:-5}"
		fi
		ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
        dwmstatus.sh update
		;;
	"-d" | "--dec" | "dec" | "-")
		if [ -f "$boost_overwrite_file" ]; then
			pamixer -d "${2:-5}" --allow-boost
		else
			pamixer -d "${2:-5}"
		fi
		ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
        dwmstatus.sh update
		;;
	"-s" | "--set" | "set" | "=")
		if [ -f "$boost_overwrite_file" ]; then
			pamixer --set-volume "${2:-5}" --allow-boost
		else
			pamixer --set-volume "${2:-5}"
		fi
        dwmstatus.sh update
		;;
	"-g" | "--get" | "get")
		pamixer --get-volume
        dwmstatus.sh update
		;;
	"-t" | "--toggle" | "toggle")
		case $2 in
			mute | "") pamixer -t ;;
			mic | microphone) pamixer --default-source -t ;;
			# Technically no toggle; may change later
			mic-unmute | microphone-unmute) pamixer --default-source -u ;;
		esac
        dwmstatus.sh update
		;;
	"-b" | "--boost" )
		touch "$boost_overwrite_file"
		;;
esac


if pamixer --get-mute > /dev/null; then
    icon="婢"
else
    icon="墳"
fi

echo "$icon $(pamixer --get-volume)%"
