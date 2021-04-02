#!/bin/sh
# Dependencies: dunstify gawk mpv youtube-dl dmenu


dunstify_id="6661"
hist_file="/tmp/menu-mpv-history"
input="$(cat ~/.config/assets/mpv-bookmarks.txt "$hist_file" | dmenu -p "URL: " -l 10)"
[ -z "$input" ] && exit

# clipboard implementation
case $input in clip | clipboard)
    input="$(xclip -o --selection clipboard)"
    ;;
esac

# url vs yt search
if echo "$input" | grep -E "^(https?://)?([A-Za-z0-9_.\-~]*\.)+[A-Za-z0-9_.\-~]+(/[A-Za-z0-9_.\-~]*)*$"; then
	url="$input"

	# prepend https:// if necessary
	[ -z "$url" ] && exit
	echo "$url" | grep "https://\|http://" || url="https://$url"

	# provide user with information about their request
	if youtube-dl -s "$url" --playlist-items 1; then
		dunstify -r "$dunstify_id" -a mpv "$(printf "Loading URL:\n%s" "$url")"
		sleep 1
		dunstify --close "$dunstify_id"
	else
		dunstify -r "$dunstify_id" -a mpv "$(printf "Unable to find a video under the given url:\n%s" "$url")"
	fi &
else
	dunstify -r "$dunstify_id" -a mpv "$(printf "Searching Youtube for '%s'" "$input")"
	query="$(echo "$input" | sed 's/ /+/g')"
	videoids="$(
	curl -s "https://www.youtube.com/results?search_query=$query" | \
		grep -oP "\"videoRenderer\":{\"videoId\":\"...........\".+?\"text\":\".+?(?=\")" | \
		awk -F\" '{ print $6 " " $NF}')"
	input="$(echo "$videoids" | cut -d' ' -f1 --complement |
		dmenu -p " " -l 15)"
	[ -z "$input" ] && exit
	videoid="$(echo "$videoids" | grep -F "$input" | cut -d' ' -f1 | head -n 1)"
	echo videoid: $videoid input: $input
	url="https://youtu.be/$videoid"
	dunstify -r "$dunstify_id" -a mpv "$(printf "Loading URL:\n%s" "$url")"
fi

# url vs yt search

mpv --idle=once "$url" \
    && ( echo "$url"; cat "$hist_file" ) | gawk '!a[$0]++' > "$hist_file.sec" && cp "$hist_file.sec" "$hist_file"
