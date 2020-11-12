#!/bin/sh

connected="$(xrandr | grep " connected " | cut -d " " -f 1)"
disconnected="$(xrandr | grep " disconnected " | cut -d " " -f 1)"

# Model can be obtained by (xrandr | grep " connected " | cut -d " " -f 1) (the -v option)
my_hostname="T440"
my_internal_screen="eDP-1"

for display in $connected; do
	if [ "$display" = "$my_internal_screen" ] \
            && [ "$my_hostname" = "$(< /etc/hostname)" ] \
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
setxkbmap de nodeadkeys -option -option caps:escape_shifted_capslock -option lv3:ralt_alt -option lv3:lwin_switch

if pgrep polybar > /dev/null; then
	echo
	echo "Restarting polybar"
	"$HOME"/.config/polybar/launch.sh > /dev/null
fi

wallpaper.sh load
(sleep 90; nice -n 5 lock.sh pre-gen)&

# Configure touchscreen on T440
[ "$(< /etc/hostname)" = "T440" ] && xinput --map-to-output 'ELAN Touchscreen' eDP-1

