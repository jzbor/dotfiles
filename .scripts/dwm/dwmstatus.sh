#!/bin/bash

statusline=""

add_block () {
	content="$1"
	index="$2"
	nmatch="$3"

	if ! [ -z "$content" ] && ( [ -z "$nmatch" ] || ! [ "$content" = "$nmatch" ] ); then
    	statusline="$statusline\x0$index $content |"
	else
    	statusline="$statusline\x0$index"
	fi
}

help () {
    echo "Options for $0:"
    echo "    status: prints the current status to stdout"
    echo "    loop:   set status to WM_NAME in a loop"
    echo "    update: immediatly update status in WM_NAME"
    echo "    action: execute action (STATUSCMD and BUTTON give block and mouse button)"
}

loop () {
    (pa_loop) &

    while true; do
        set_status
        sleep 5 2> /dev/null
    done
}

### BLOCK FUNCTIONS

pa_volume () {
    pactl get-sink-volume @DEFAULT_SINK@ | grep "Volume" | sed 's/.*\/\s*\(.*\) \s*\/.*/\1/;'
}

pa_muted () {
    if pactl get-sink-mute @DEFAULT_SINK@ | grep no > /dev/null; then
        return 1
    else
        return 0
    fi
}

pa_loop () {
    volume="$(pa_volume)"
    pactl subscribe | grep --line-buffered "Event 'change' on sink" | while read line; do
        temp="$(pa_volume)"
        if [ "$volume" != "$temp" ]; then
            set_status
        fi
    done
}

volume () {
    if [ "$MOONWM_NERDFONT" = "0" ]; then
        icon=''
    elif pa_muted; then
        icon='婢 '
    else
        icon='墳 '
    fi
    printf "%s%s%%" "$icon" "$(pa_volume)"
}

timedate () {
    if [ "$MOONWM_NERDFONT" = "0" ]; then
        icon=''
    else
        icon=' '
    fi
    printf "%s%s" "$icon" "$(date +%R)"
}

set_status () {
    moonctl status "$(get_status)" || exit
}

get_status () {
    statusline=""

    add_block "$(extra-tray.sh)" 1
    add_block "$(pgrep screencast > /dev/null 2>&1 && echo "雷")" 2
    add_block " $(setxkbmap -query | grep '^layout:' | sed 's/.* //')" 3 " us,de"
    add_block "$(music.sh status-small)" 4
    add_block "$(volume)" 5
    add_block "$(ethernet.sh) $(wifi.sh) $(bluetooth.sh)" 6
    add_block " $(date +%R)" 7

	if [ -d /proc/acpi/button/lid ]; then
    	device=" "
    else
    	device=""
	fi

    printf "$statusline| $device\n"
}

action () {
    # notify-send "$STATUSCMDN $BUTTON"
    case $BUTTON in
        8) mpv; return;;
        9) spotify.sh; return;;
    esac
    case "$STATUSCMDN" in
        0) tray-options.sh $BUTTON;;
        1) killall -2 -g screencast ;;
        2) wmc-utils setup-keyboard;;
        3) dwmmusic.sh $BUTTON;;
        4) dwmvolume.sh $BUTTON;;
        5) dwmnetwork.sh $BUTTON;;
        6) dwmdate.sh $BUTTON;;
        *) notify-send "out of range ($STATUSCMDN)"
    esac
}


case $1 in
    status)
        get_status;;
    update)
        set_status;;
    loop | '')
        loop;;
    action)
        action;;
    help)
        help;;
esac
