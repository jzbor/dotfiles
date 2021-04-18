#!/bin/sh

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
    while true; do
        set_status
        sleep 2 2> /dev/null
    done
}

set_status () {
    xsetroot -name "$(get_status)" || exit
}

get_status () {
    statusline=""

    add_block "$(extra-tray.sh)" 1
    add_block " $(setxkbmap -query | grep '^layout:' | sed 's/.* //')" 2 " us,de"
    add_block "$(music.sh status-small)" 3
    add_block "$(volume.sh)%" 4
    add_block "$(ethernet.sh) $(wifi.sh) $(bluetooth.sh)" 5
    add_block " $(date +%R)" 6

	if [ -d /proc/acpi/button/lid ]; then
    	device=" "
    else
    	device=""
	fi

    printf "$statusline| $device\n"
}

action () {
    # notify-send "$STATUSCMDN $BUTTON"
    case "$STATUSCMDN" in
        0) tray-options.sh $BUTTON;;
        2) dwmmusic.sh $BUTTON;;
        3) dwmvolume.sh $BUTTON;;
        4) dwmnetwork.sh $BUTTON;;
        5) dwmdate.sh $BUTTON;;
        *) notify-send "out of range ($STATUSCMDN)"
    esac
}


case $1 in
    status)
        get_status;;
    update)
        set_status;;
    loop)
        loop;;
    action)
        action;;
    help)
        help;;
esac
