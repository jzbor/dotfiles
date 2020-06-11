#!/bin/bash


last_player="/tmp/.lastplayer"

# Timeout because MPRIS bus (or something similar) gets bricked on
# multiple (incorrectly) loaded spotify clients
shopt -s expand_aliases
alias playerctl="timeout -k 15s 15s playerctl"

get_title () {
    player="$1"
    # Set title
    title="$(playerctl -p "$player" metadata title 2> /dev/null)"
    if (( ${#title} > 20 )); then
	title="${title::17}..."
    fi
    echo "$title"
}

get_artist() {
    player="$1"
    # Set artist
    artist="$(playerctl -p "$player" metadata artist 2> /dev/null)"
    # Workaround if artist is not set
    if [ "$artist" = "" ]; then
	artist="$(playerctl -p "$player" metadata album 2> /dev/null)"
    fi
    if (( ${#artist} > 20 )); then
	artist="${artist::17}..."
    fi
    echo "$artist"
}

get_file() {
    player="$1"
    url="$(playerctl -p "$player" metadata xesam:url)"
    superdir="$(basename "$(dirname "$url")")"
    file="$(basename "$url")"
    echo "$superdir / $file"
}

open_spotify_if_necessary () {
    echo $1
    if [ "$1" = "" ] && ! pidof spotify > /dev/null 2>&1; then
	killall -9 spotify 2> /dev/null
	echo Starting Spotify...
	setsid -f spotify > /dev/null 2>&1
	while ! [ "$(playerctl status -p spotify)" = "Paused" ] \
	    && ! [ "$(playerctl status -p spotify)" = "Stopped" ] \
	    && ! [ "$(playerctl status -p spotify)" = "Playing" ]; do
	    sleep 0.5
	done
	sleep 5
    fi
}

# Update current player
if [ "$(playerctl -p Lollypop status 2> /dev/null)" = "Playing" ]; then
    player="Lollypop"
    echo $player > $last_player
elif [ "$(playerctl -p vlc status 2> /dev/null)" = "Playing" ]; then
    player="vlc"
    echo $player > $last_player
elif [ "$(playerctl -p spotify status 2> /dev/null)" = "Playing" ]; then
    player="spotify"
    echo $player > $last_player
elif [ -f "$last_player" ]; then
    player="$(cat $last_player)"
    playerctl status -p "$player" > /dev/null 2>&1 || player="Lollypop,spotify,vlc"
else
    player="Lollypop,spotify,vlc"
fi


status=$(playerctl -p $player status 2> /dev/null)


if [ "$#" -gt "0" ]; then
    case $1 in
	"play" | "play-pause")
	    open_spotify_if_necessary "$status"
	    playerctl -p $player play-pause
	    ;;
	"pause")
	    open_spotify_if_necessary "$status"
	    playerctl -p $player pause
	    ;;
	"prev" | "previous")
	    open_spotify_if_necessary "$status"
	    playerctl -p $player previous
	    ;;
	"next")
	    open_spotify_if_necessary "$status"
	    playerctl -p $player next
	    ;;
    esac
fi


if [ $? != 0 ] || [ "$status" == "Stopped" ]
then
    echo "   Sound of Silence"
else
    pre_icon=
    if [ "$status" = "Playing" ]; then
	pre_icon=
    else
	pre_icon=
    fi

    title="$(get_title $player)"
    artist="$(get_artist $player)"

    if [ "$title" = "" ] && [ "$artist" = "" ]; then
	echo " $pre_icon  $(get_file $player) "
    else
	echo " $pre_icon  $artist - $title "
    fi
fi
