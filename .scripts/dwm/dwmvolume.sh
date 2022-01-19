#!/bin/sh
# Dependencies: volume.sh pacmd pactl sh xmenu


select_volume () {
	menu="      100%	volume.sh --set 100
       90%	pademelon-tools volume --set 90
       80%	pademelon-tools volume --set 80
       70%	pademelon-tools volume --set 70
       60%	pademelon-tools volume --set 60
       50%	pademelon-tools volume --set 50
       40%	pademelon-tools volume --set 40
       30%	pademelon-tools volume --set 30
       20%	pademelon-tools volume --set 20
       10%	pademelon-tools volume --set 10"

	echo "$menu" | xmenu | sh
}

gen_output_menu () {
	pactl list short sinks | cut -f1,2 | sed 's/\(.*\)\t.*\.\(.*\)/\t\1 \2\tpacmd set-default-sink \1/'
}

gen_input_menu () {
	pactl list short sources | cut -f1,2 | sed 's/\(.*\)\t.*\.\(.*\)/\t\1 \2\tpacmd set-default-source \1/'
}


audio_menu () {
	menu="ﱝ  Mute	pademelon-tools volume --mute toggle
  Mute Microphone	pademelon-tools volume --mute-input toggle

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
    2) pademelon-tools volume --mute toggle ;;
    3) audio_menu ;;
    4) pademelon-tools volume --inc 5 ;;
    5) pademelon-tools volume --dec 5;;
esac
