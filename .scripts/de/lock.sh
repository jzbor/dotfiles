#!/bin/bash
get_xr () {
    xrdb -query -all | grep "$1": | sed "s/.*#/#/g" | tail -n1
}

opacity="87.5%"
bg_color="$(get_xr themeBackground)"
fg_color="$(get_xr themeForeground)"
background_file="$HOME/.config/assets/background"
lock_file="/tmp/lock.jpg"


title="$(playerctl metadata xesam:title)"
artist="$(playerctl metadata xesam:artist)"
primary_resolution="$(xrandr | grep primary | cut -d ' ' -f 4 | sed 's/+.*//')"
cache_file="/tmp/prelock-$primary_resolution-$(sum $background_file | sed 's/\s.*//').jpg"


if (( ${#title} > 28 )); then
    title="${title::25}..."
fi
if (( ${#artist} > 28 )); then
    title="${artist::25}..."
fi


if ! [ -f $cache_file ]; then
    echo "Pre-generated image not found; Generating..."
    convert -blur 0x8 -resize "$primary_resolution"^ -crop "$primary_resolution"+0+0\! "$background_file" \
	-gravity center -size 400x150 canvas:"$bg_color" -geometry +77-27 -alpha set -channel A -evaluate set "$opacity" +channel -composite \
	-gravity center -size 150x150 canvas:"$bg_color" -geometry -202-27 -alpha set -channel A -evaluate set "$opacity" +channel -composite \
	-gravity center -size 554x50 canvas:"$bg_color" -geometry +0+77 -alpha set -channel A -evaluate set "$opacity" +channel -composite \
	-fill "$fg_color" -font Fira-Code-Bold-Nerd-Font-Complete  -pointsize 100 -gravity center -annotate -202-27 "" \
	"$cache_file"
else
    echo "Using pre-generated image"
fi

# Allows for 'lock.sh pre-gen' to only generate the image (e.g. on startup)
[ "$1" = "pre-gen" ] && exit


if [ -n "$title" ]; then
    convert "$cache_file" \
	-fill "$fg_color" -font Fira-Sans-Book -pointsize 18 -gravity center -annotate +0+77 "$artist - $title" \
	"$lock_file"
else
    convert "$cache_file" \
	-fill "$fg_color" -font Fira-Sans-Book -pointsize 18 -gravity center -annotate +0+77 "$USER@$(hostname)" \
	"$lock_file"
fi

i3lock -i "$lock_file" --radius 65 --indpos="x+w/2-202:y+h/2-27" --ring-width=5 \
    --screen=1 --color="$bg_color" \
    --insidecolor=00000000 --insidevercolor=00000000 --insidewrongcolor=00000000 \
    --ringcolor="$fg_color"FF --ringvercolor="$(get_xr themeSelector)"FF --ringwrongcolor="$(get_xr themeUrgent)"FF \
    --line-uses-inside --keyhlcolor="$(get_xr themeSelector)"FF --bshlcolor="$(get_xr themeSelector)"FF \
    --veriftext="" --wrongtext="" --noinputtext="" --locktext="" \
    --clock --timecolor="$(get_xr themeForeground)"FF --timepos="x+w/2+77:y+h/2-27+10" \
    --datecolor="$(get_xr themeForeground)"FF --datestr="%A, %d.%m.%Y"\
    --timesize="60" --datesize="20" \
    --date-align center



# Cleanup
rm "$cover_file" "$lock_file"
