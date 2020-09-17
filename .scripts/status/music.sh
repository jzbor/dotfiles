#!/bin/bash

last_player_file="/tmp/.lastplayer"
meta_file="/tmp/music-meta"
icon_file="/tmp/music-icon"
status_file="/tmp/music-status"

ignore_list="firefox"
no_player_msg="No player found"

format() {
    artist="$1"
    title="$2"
    if [ "$3" = "" ]; then
	delim="—"
    else
	delim="$3"
    fi

    if (( ${#artist} > 20 )); then
	artist="${artist::17}..."
    fi
    if (( ${#title} > 20 )); then
	title="${title::17}..."
    fi

    echo "$artist $delim $title"
}

eval_metadata() {
    while read -r; do
	case $REPLY in
	    *xesam:artist*)
		artist="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
		format "$artist" "$title" > $meta_file

		# Update player for media control
		echo $REPLY | cut -d' ' -f1 > $last_player_file
		;;
	    *xesam:title*)
		title="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
		format "$artist" "$title" > $meta_file

		# Update player for media control
		echo $REPLY | cut -d' ' -f1 > $last_player_file
		;;
	    *xesam:url*)
		url="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
		player="$(echo $REPLY | cut -d' ' -f1)"
		if echo "$url" | grep '^file://' > /dev/null \
			&& ! playerctl -p "$player" metadata title 2> /dev/null; then
		    superdir="$(basename "$(dirname "$url")")"
		    file="$(basename "$url")"
		    format "$superdir" "$file" > $meta_file
		fi

		# Update player for media control
		echo $REPLY | cut -d' ' -f1 > $last_player_file
		;;
	esac
    done
}

get_player() {
    if playerctl -i "$ignore_list" status | grep Playing > /dev/null; then
	playerctl -i "$ignore_list" metadata | head -n 1 | cut -d' ' -f1
    elif [ -f "$last_player_file" ]; then
	cat $last_player_file
    else
	playerctl -i "$ignore_list" metadata | head -n 1 | cut -d' ' -f1
    fi
}


loop() {
    [ -f $status_file ] || echo "$no_player_msg" > $status_file
    (playerctl -i "$ignore_list" -F status 2> /dev/null & \
	playerctl -a -i "$ignore_list" -F metadata 2> /dev/null)  | while read -r; do
	case $REPLY in
	    *xesam:artist*)
		artist="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
		format "$artist" "$title" > $meta_file

		# Update player for media control
		echo $REPLY | cut -d' ' -f1 > $last_player_file
		;;
	    *xesam:title*)
		title="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
		format "$artist" "$title" > $meta_file

		# Update player for media control
		echo $REPLY | cut -d' ' -f1 > $last_player_file
		;;
	    *xesam:url*)
		url="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
		player="$(echo $REPLY | cut -d' ' -f1)"
		if echo "$url" | grep '^file://' > /dev/null \
			&& ! playerctl -p "$player" metadata title 2> /dev/null; then
		    superdir="$(basename "$(dirname "$url")")"
		    file="$(basename "$url")"
		    format "$superdir" "$file" > $meta_file
		fi

		# Update player for media control
		echo $REPLY | cut -d' ' -f1 > $last_player_file
		;;
	    Playing)
		echo "" > $icon_file
		# Update metadata on status change
		playerctl -p "$(get_player 2> /dev/null)" metadata 2> /dev/null | eval_metadata
		;;
	    Paused)
		echo "" > $icon_file
		# Update metadata on status change
		playerctl -p "$(get_player 2> /dev/null)" metadata 2> /dev/null | eval_metadata
		;;
	    Stopped)
		echo "" > $icon_file
		# Update metadata on status change
		playerctl -p "$(get_player 2> /dev/null)" metadata 2> /dev/null | eval_metadata
		;;
	esac
	printf '%s  %s\n' "$(< $icon_file)" "$(< $meta_file)" > $status_file
	dwmstatus-update.sh
    done
}



case $1 in
    loop)
	# Ensure no other loops are running
	pgrep "$(basename $0)" | grep -v "$$" | xargs kill -9 2> /dev/null
	# Update to current state
	rm $status_file
	eval_metadata
	loop
	;;
    '' | status)
	cat $status_file
	;;
    lock | lock-status)
	cat $status_file | sed 's/. *//'
	;;
    statusfile)
	echo $status_file
	;;
    has-player)
	[ -f $status_file ] && ! [ "$(cat $status_file)" = "$no_player_msg" ]
	;;
    *)
	playerctl -p "$(get_player 2> /dev/null)" $1 > /dev/null 2>&1
	cat $status_file
	;;
esac
