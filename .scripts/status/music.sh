#!/bin/bash

last_player_file="/tmp/.lastplayer"
meta_file="/tmp/music-meta"
icon_file="/tmp/music-icon"
status_file="/tmp/music-status"

format() {
    artist="$1"
    title="$2"
    if [ "$3" = "" ]; then
	delim="-"
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
		artist="$(echo "$REPLY" | sed 's/^[a-zA-Z]* *[a-zA-Z:]* *//')"
		format "$artist" "$title" > $meta_file

		# Update player for media control
		echo $REPLY | cut -d' ' -f1 > $last_player_file
		;;
	    *xesam:title*)
		title="$(echo "$REPLY" | sed 's/^[a-zA-Z]* *[a-zA-Z:]* *//')"
		format "$artist" "$title" > $meta_file

		# Update player for media control
		echo $REPLY | cut -d' ' -f1 > $last_player_file
		;;
	    *xesam:url*)
		url="$(echo "$REPLY" | sed 's/^[a-zA-Z]* *[a-zA-Z:]* *//')"
		player="$(echo $REPLY | cut -d' ' -f1)"
		if [ "$url" = "file://*" ] && ! playerctl -p "$player" metadata title; then
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
    if playerctl -i firefox status | grep Playing > /dev/null; then
	playerctl -i firefox metadata | head -n 1 | cut -d' ' -f1
    elif [ -f "$last_player_file" ]; then
	cat $last_player_file
    else
	playerctl -i firefox metadata | head -n 1 | cut -d' ' -f1
    fi
}


loop() {
    (playerctl -i firefox -F status 2> /dev/null & \
	playerctl -a -i firefox -F metadata 2> /dev/null)  | while read -r; do
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
		playerctl -p "$(get_player)" metadata 2> /dev/null | eval_metadata
		;;
	    Paused)
		echo "" > $icon_file
		# Update metadata on status change
		playerctl -p "$(get_player)" metadata 2> /dev/null | eval_metadata
		;;
	    Stopped)
		echo "" > $icon_file
		# Update metadata on status change
		playerctl -p "$(get_player)" metadata 2> /dev/null | eval_metadata
		;;
	esac
	printf '%s  %s\n' "$(< $icon_file)" "$(< $meta_file)" > $status_file
    done
}



case $1 in
    loop)
	# Ensure no other loops are running
	pgrep "$(basename $0)" | grep -v "$$" | xargs kill -9 2> /dev/null
	loop
	;;
    '' | status)
	cat $status_file
	;;
    *)
	playerctl -p "$(get_player)" $1 > /dev/null
	cat $status_file
	;;
esac


# cat $status_dir/status
