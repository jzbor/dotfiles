#!/bin/sh
# Check dependencies
DEPENDENCIES="volume.sh pacmd pactl sh xmenu"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


select_volume () {
	menu="      100%	volume.sh --set 100
       90%	volume.sh --set 90
       80%	volume.sh --set 80
       70%	volume.sh --set 70
       60%	volume.sh --set 60
       50%	volume.sh --set 50
       40%	volume.sh --set 40
       30%	volume.sh --set 30
       20%	volume.sh --set 20
       10%	volume.sh --set 10"

	echo "$menu" | xmenu | sh
}

gen_output_menu () {
	pactl list short sinks | cut -f1,2 | sed 's/\(.*\)\t.*\.\(.*\)/\t\1 \2\tpacmd set-default-sink \1/'
}

gen_input_menu () {
	pactl list short sources | cut -f1,2 | sed 's/\(.*\)\t.*\.\(.*\)/\t\1 \2\tpacmd set-default-source \1/'
}


audio_menu () {
	menu="ﱝ  Mute	volume.sh -t
  Mute Microphone	volume.sh -t mic

蓼  Select Output
$(gen_output_menu)
  Select Input
$(gen_input_menu)

ﲿ  Audio Setup	pavucontrol
漣  Pulse Settings	paprefs"

	echo "$menu" | xmenu | sh
}

case $1 in
    1) select_volume ;;
    2) volume.sh -t ;;
    3) audio_menu ;;
    4) volume.sh -i ;;
    5) volume.sh -d ;;
esac
