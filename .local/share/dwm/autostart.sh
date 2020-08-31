#!/bin/sh

wmname LG3D

dwmstatus.sh &

setup_displays.sh &

(killall -9 picom && sleep 0.2; picom --experimental-backends) &

/usr/lib/kdeconnectd &

/usr/lib/geoclue-2.0/demos/agent &

redshift-gtk &

nextcloud --background &

dunst.sh

spicetify update &

libinput-gestures-setup restart &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

nm-applet &

xfce4-power-manager &

clipit &

music.sh loop &
