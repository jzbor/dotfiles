#!/bin/sh
# Check dependencies
DEPENDENCIES="dunstify gawk mpv rofi youtube-dl"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


dunstify_id="6661"
hist_file="/tmp/rofi-mpv-history"
url="$(cat ~/.config/assets/mpv-bookmarks.txt "$hist_file" | rofi -dmenu -p "URL: ")"

# clipboard implementation
case $url in clip | clipboard)
    url="$(xclip -o --selection clipboard)"
    ;;
esac

[ -z "$url" ] && exit
echo "$url" | grep "https://\|http://" || url="https://$url"

if youtube-dl -s "$url" --playlist-items 1; then
    dunstify -r "$dunstify_id" -a mpv "$(printf "Loading URL:\n%s" "$url")"
    sleep 1
    dunstify --close "$dunstify_id"
else
    dunstify -r "$dunstify_id" -a mpv "$(printf "Unable to find a video under the given url:\n%s" "$url")"
fi &

mpv --idle=once "$url" \
    && ( echo "$url"; cat "$hist_file" ) | gawk '!a[$0]++' > "$hist_file.sec" && cp "$hist_file.sec" "$hist_file"
