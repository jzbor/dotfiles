#!/bin/bash
get_xr () {
    xrdb -query -all | grep "$1": | sed "s/.*#/#/g" | tail -n1
}

opacity="87.5%"
bg_color="$(get_xr themeBackground)"
fg_color="$(get_xr themeForeground)"
background_file="$HOME/.config/assets/background.jpg"
cover_file="/tmp/cover.jpg"
lock_file="/tmp/lock.jpg"

playerctl metadata mpris:artUrl | xargs -i curl '{}' -L --silent > "$cover_file"
title="$(playerctl metadata xesam:title)"
artist="$(playerctl metadata xesam:artist)"
primary_resolution="$(xrandr | grep primary | cut -d ' ' -f 4 | sed 's/+.*//')"

if (( ${#title} > 28 )); then
    title="${title::25}..."
fi
if (( ${#artist} > 28 )); then
    title="${artist::25}..."
fi

if identify -format "%f" "$cover_file" > /dev/null ; then
    convert -blur 0x8 -crop "$primary_resolution"+0+0\! "$background_file" \
	-gravity center -size 400x500 canvas:"$bg_color" -alpha set -channel A -evaluate set "$opacity" +channel -composite \
	-gravity center "$cover_file" -geometry +0-50 -composite \
	-fill "$fg_color"  -font Fira-Sans-Regular  -pointsize 30 -gravity center -annotate +0+150 "$title" \
	-fill "$fg_color"  -font Fira-Sans-Regular  -pointsize 30 -gravity center -annotate +0+200 "$artist" \
	"$lock_file"
else
    convert -blur 0x8 -crop "$primary_resolution"+0+0\! "$background_file" \
	"$lock_file"
fi

i3lock -i "$lock_file" --radius 50 --indpos="w-100:h-100" --ring-width=5 \
    --screen=1 --color="$bg_color" \
    --insidecolor=00000000 --insidevercolor=00000000 --insidewrongcolor=00000000 \
    --ringcolor="$fg_color"FF --ringvercolor="$(get_xr themeSelector)"FF --ringwrongcolor="$(get_xr themeUrgent)"FF \
    --line-uses-inside --keyhlcolor="$(get_xr themeSelector)"FF --bshlcolor="$(get_xr themeSelector)"FF \
    --veriftext="" --wrongtext="" --noinputtext="" --locktext=""

# Cleanup
rm "$cover_file" "$lock_file"
