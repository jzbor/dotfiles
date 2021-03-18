#!/bin/bash
# Dependencies: dwmstatus.sh pgrep playerctl


# https://specifications.freedesktop.org/mpris-spec/latest/Player_Interface.html#Property:Metadata

last_player_file="/tmp/.lastplayer"
icon_file="/tmp/music-icon"
artist_file="/tmp/music-artist"
title_file="/tmp/music-title"

ignore_list="firefox,chromium"
no_player_msg="No player found"

format() {
    if ! [ -f "$title_file" ] || ! [ -f "$icon_file" ] || ! [ -f "$artist_file" ]; then
        return
    fi

	artist="$(< $artist_file)"
	title="$(< $title_file)"
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

	# echo "$artist $delim $title"
	printf '%s  %s %s %s\n' "$(< $icon_file)" "$artist" "$delim" "$title"
}

format_small() {
    if ! [ -f "$title_file" ] || ! [ -f "$icon_file" ]; then
        return
    fi

	title="$(< $title_file)"

	if (( ${#title} > 20 )); then
		title="${title::17}..."
	fi

	# echo "$artist $delim $title"
	printf '%s  %s\n' "$(< $icon_file)" "$title"
}

eval_metadata() {
	playerctl -p "$(get_player 2> /dev/null)" metadata 2> /dev/null | while read -r; do
		case $REPLY in
			*xesam:artist*)
				artist="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
				echo "$artist" > $artist_file

				# Update player for media control
				echo $REPLY | cut -d' ' -f1 > $last_player_file
				;;
			*xesam:title*)
				title="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
				echo "$title" > $title_file

				# Update player for media control
				echo $REPLY | cut -d' ' -f1 > $last_player_file
				;;
			*xesam:url*)
				url="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
				player="$(echo $REPLY | cut -d' ' -f1)"
				if echo "$url" | grep '^file://' > /dev/null \
					&& ! playerctl -p "$player" metadata title 2> /dev/null; then
							# directory of file
							basename "$(dirname "$url")" > $artist_file
							# file name
							basename "$url" > $title_file
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
	(playerctl -i "$ignore_list" -F status 2> /dev/null & \
			playerctl -a -i "$ignore_list" -F metadata 2> /dev/null)  | while read -r; do
		case $REPLY in
			*xesam:artist*)
				artist="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
				echo "$artist" > $artist_file

				# Update player for media control
				echo $REPLY | cut -d' ' -f1 > $last_player_file
				;;
			*xesam:title*)
				title="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
				# mpv-mpris workaround (it was spaming the title causing updates)
				# [ "$title" = "$(< $title_file)" ] && continue
				echo "$title" > $title_file

				# Update metadata on status change (kinda mpv workaround)
				playerctl -p "$(echo $REPLY | cut -d' ' -f1)" metadata artist > /dev/null 2>&1 \
					|| echo > "$artist_file"
				eval_metadata

				# Update player for media control
				echo $REPLY | cut -d' ' -f1 > $last_player_file
				;;
			*xesam:url*)
				url="$(echo "$REPLY" | sed 's/^[a-zA-Z0-9\.-_]* *[a-zA-Z:]* *//')"
				player="$(echo $REPLY | cut -d' ' -f1)"
				if echo "$url" | grep '^file://' > /dev/null \
						&& ! playerctl -p "$player" metadata title 2> /dev/null; then
					# directory of file
					basename "$(dirname "$url")" > $artist_file
					# file name
					basename "$url" > $title_file
				fi

				# Update player for media control
				echo $REPLY | cut -d' ' -f1 > $last_player_file
				;;
			Playing)
				echo "" > $icon_file
				# Update metadata on status change
				eval_metadata
				;;
			Paused)
				echo "" > $icon_file
				# Update metadata on status change
				eval_metadata
				;;
			Stopped)
				echo "" > $icon_file
				# Update metadata on status change
				eval_metadata
				;;
		esac
		dwmstatus.sh update &
	done
}



case $1 in
	loop)
		# Ensure no other loops are running
		pgrep "$(basename $0)" | grep -v "$$" | xargs kill -9 2> /dev/null
		# Update metadata on status change
		eval_metadata
		loop
		;;
	'' | status | lock-status)
		format
		;;
	status-small)
		format_small
		;;
	has-player)
		playerctl status -i "$ignore_list" > /dev/null 2>&1
		;;
	*)
		playerctl -p "$(get_player 2> /dev/null)" $1 > /dev/null 2>&1
		format
		;;
esac
