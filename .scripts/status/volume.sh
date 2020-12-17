#!/bin/sh

case $1 in
    "-i" | "--inc" | "inc" | "+")
	pamixer -i "${2:-5}"
	ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
	dwmstatus-update.sh
	;;
    "-d" | "--dec" | "dec" | "-")
	pamixer -d "${2:-5}"
	ffplay -nodisp -autoexit /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
	dwmstatus-update.sh
	;;
    "-s" | "--set" | "set" | "=")
	pamixer --set-volume "$2"
	dwmstatus-update.sh
	;;
    "-g" | "--get" | "get")
	pamixer --get-volume
	dwmstatus-update.sh
	;;
    "-t" | "--toggle" | "toggle")
	case $2 in
	    mute | "") pamixer -t ;;
	    mic | microphone) pamixer --default-source -t ;;
	    # Technically no toggle; may change later
	    mic-unmute | microphone-unmute) pamixer --default-source -u ;;
	esac
	dwmstatus-update.sh
	;;
esac


if pamixer --get-mute > /dev/null; then
    icon="婢"
else
    icon="墳"
fi

echo "$icon $(pamixer --get-volume)%"
