#!/bin/sh

# This script has to be executable multiple times without spawning multiple instances of the same program

# Configure X
wmname LG3D
setup_displays.sh
sxhkd &

# Daemons that automatically check for running instances
/usr/lib/kdeconnectd &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
music.sh loop &

# Other daemons
dunst.sh &

# Applications
nextcloud --background &
spicetify update &

# Applets & tray icons
kdeconnect-indicator &
nm-applet &
xfce4-power-manager &
(killall clipit; clipit) &
(killall -9 /usr/lib/geoclue-2.0/demos/agent; /usr/lib/geoclue-2.0/demos/agent & sleep 5;
	killall -9 redshift-gtk; killall -9 redshift; redshift-gtk) &

# Start compositor
(killall -9 picom-guardian.sh; picom-guardian.sh) &

libinput-gestures-setup restart &
