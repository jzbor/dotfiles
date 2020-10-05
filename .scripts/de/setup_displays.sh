#!/bin/sh

connected="$(xrandr | grep " connected " | cut -d " " -f 1)"
disconnected="$(xrandr | grep " disconnected " | cut -d " " -f 1)"
model_info="$(inxi -M | head -n 1)"

# Model can be obtained by (xrandr | grep " connected " | cut -d " " -f 1) (the -v option)
my_model="ThinkPad T440"
my_internal_screen="eDP-1"

for display in $connected; do
	if [ "$display" = "$my_internal_screen" ] \
			&& echo "$model_info" | grep "$my_model" > /dev/null \
			&& grep closed /proc/acpi/button/lid/LID/state > /dev/null ; then
		echo "Disabling $display (closed lid)"
		xrandr --output "$display" --off
	elif [ -z "$last" ]; then
		echo "Setting up first display: $display"
		xrandr --output "$display" --auto --primary
		last="$display"
	else
		echo "Setting up $display next to $display"
		xrandr --output "$display" --auto --right-of "$last"
	fi
done


# Preventing initialization of VIRTUAL1 on undock
for display in $disconnected; do
	xrandr --output $display --off
done

# Reset keyboard map
setxkbmap de -option caps:escape

if pgrep polybar > /dev/null; then
	echo
	echo "Restarting polybar"
	"$HOME"/.config/polybar/launch.sh > /dev/null
fi

wallpaper.sh load
(sleep 90; nice -n 5 lock.sh pre-gen)&

# Configure touchscreen on T440
[ "$(hostname)" = "T440" ] && xinput --map-to-output 'ELAN Touchscreen' eDP-1
