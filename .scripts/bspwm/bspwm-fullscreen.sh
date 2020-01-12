#!/bin/bash

handle_event () {
    event_type="$1"
    monitor="$2"
    desktop="$3"
    layout="$5 $6"

    echo $layout
    monitor_name=$(bspc query -m $monitor -M --names)

    case $layout in
	"fullscreen on")
	    #xdo lower -n polybar
	    xdo lower -n polybar-$monitor_name
	    ;;
	"fullscreen off")
	    #xdo raise -n polybar
	    xdo raise -n polybar-$monitor_name
	    ;;
	*)
	    ;;
    esac

}


while read -r event; do handle_event $event; done < <(bspc subscribe node_state)
