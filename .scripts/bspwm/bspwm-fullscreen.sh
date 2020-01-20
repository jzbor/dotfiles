#!/bin/bash

fullscreened_moved () {
    event_type="$1"
    src_monitor="$2"
    dst_monitor="$5"
    src_monitor_name=$(bspc query -m $src_monitor -M --names)
    dst_monitor_name=$(bspc query -m $dst_monitor -M --names)


}

handle_event () {
    event_type="$1"
    monitor="$2"
    desktop="$3"
    node="$4"
    layout="$5 $6"
    monitor_name=$(bspc query -m $monitor -M --names)

    case $layout in
	"fullscreen on")
	    #xdo lower -n polybar
	    xdo hide -a polybar-$monitor_name

	    ;;
	"fullscreen off")
	    #xdo raise -n polybar
	    xdo show -a polybar-$monitor_name
	    ;;
	*)
	    ;;
    esac

}


while read -r event; do handle_event $event; done < <(bspc subscribe node_state)
