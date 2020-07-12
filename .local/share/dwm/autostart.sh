#!/bin/sh

setup_displays.sh &

(killall -9 picom; picom) &

/usr/lib/kdeconnectd &

/usr/lib/geoclue-2.0/demos/agent &

redshift-gtk &

nextcloud --background &

dunst.sh

spicetify update &

libinput-gestures &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

nm-applet &

xfce4-power-manager &

clipit &

music.sh loop &
