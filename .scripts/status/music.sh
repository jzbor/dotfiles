#!/bin/bash


last_player="/tmp/.lastplayer"

get_title () {
    player="$1"
    # Set title
    title="$(playerctl -p "$player" metadata title)"
    if (( ${#title} > 20 )); then
	title="${title::17}..."
    fi
    echo "$title"
}

get_artist() {
    player="$1"
    # Set artist
    artist="$(playerctl -p "$player" metadata artist)"
    # Workaround if artist is not set
    if [ "$artist" = "" ]; then
	artist="$(playerctl -p "$player" metadata album)"
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

if [ -f "$last_player" ]; then
    player="$(cat $last_player)"
else
    player="Lollypop,spotify,vlc"
fi


if [ "$(playerctl -p Lollypop status 2> /dev/null)" = "Playing" ]; then
    player="Lollypop"
    echo $player > $last_player
elif [ "$(playerctl -p vlc status 2> /dev/null)" = "Playing" ]; then
    player="vlc"
    echo $player > $last_player
elif [ "$(playerctl -p spotify status 2> /dev/null)" = "Playing" ]; then
    player="spotify"
    echo $player > $last_player
fi


status=$(playerctl -p $player status 2> /dev/null)


if [ "$#" -gt "0" ]; then
    case $1 in
	"play" | "play-pause")
	    playerctl -p $player play-pause
	    ;;
	"pause")
	    playerctl -p $player pause
	    ;;
	"prev" | "previous")
	    playerctl -p $player previous
	    ;;
	"next")
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
