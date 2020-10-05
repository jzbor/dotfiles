# !/bin/sh

url="$(cat ~/.config/assets/web-bookmarks.txt | rofi -dmenu -p "URL: ")"
[ -z "$url" ] && exit
echo "$url" | grep "https://\|http://" || url="https://$url"
mpv --idle=once "$url"
