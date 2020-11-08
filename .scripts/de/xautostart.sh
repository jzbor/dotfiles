#!/bin/sh

# This script has to be executable multiple times without spawning multiple instances of the same program

# Configure X
wmname LG3D
setup_displays.sh
sxhkd &

# Fix spotify
#(killall -9 spotify; pulseaudio --kill; pulseaudio --start) &

# Daemons that automatically check for running instances
/usr/lib/geoclue-2.0/demos/agent &
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
(killall redshift-gtk; redshift-gtk) &

# Start compositor
picom-guardian.sh &

libinput-gestures-setup restart &
