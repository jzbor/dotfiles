#!/bin/sh
# Check dependencies
DEPENDENCIES="dunstify setxkbmap"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


get_status () {
    extra="$(extra-tray.sh)"
    [ -z "$extra" ] || extra="$extra | "

	layout="$(setxkbmap -query | grep '^layout:' | sed 's/.* //')"
	[ "$layout" != de ] && kbd_layout=" $layout | "

    music.sh has-player && music="$(music.sh status-small) | "

	if [ -d /proc/acpi/button/lid ]; then
		device=" "
	else
		device=""
	fi

    printf "$extra$kbd_layout\x02$music\x03$(volume.sh)% |\x04 $(ethernet.sh) $(wifi.sh) $(bluetooth.sh) |\x05  $(date +%R) || \x06$device"
}

kill -9 $(pgrep $(basename $0) | grep -v $$) 2> /dev/null
while true; do
    xsetroot -name "$(get_status)"
    sleep 2 2> /dev/null
done

