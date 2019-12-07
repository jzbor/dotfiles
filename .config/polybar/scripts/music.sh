#!/usr/bin/env sh


last_player="/tmp/.lastplayer"

if [ -f "$last_player" ]; then
    player="$(cat $last_player)"
else
    player="Lollypop,spotify"
fi


if [ "$(playerctl -p Lollypop status 2> /dev/null)" == "Playing" ]; then
    player="Lollypop"
    echo $player > $last_player
elif [ "$(playerctl -p spotify status 2> /dev/null)" == "Playing" ]; then
    player="spotify"
    echo $player > $last_player
fi


status=$(playerctl -p $player status 2> /dev/null)


if (( $# > 0 )); then
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
    if [ "$status" == "Playing" ]; then
	pre_icon=
    else
	pre_icon=
    fi
    artist=$(playerctl -p $player metadata artist)
    if [ "$artist" = "" ]; then
	artist=$(playerctl -p $player metadata album)
    fi
    title=$(playerctl -p $player metadata title)
    if (( ${#artist} > 20 )); then
	artist="${artist::17}..."
    fi
    if (( ${#title} > 20 )); then
	title="${title::17}..."
    fi
    echo " $pre_icon  $artist - $title "
fi
