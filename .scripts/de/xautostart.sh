#!/bin/sh

# This script has to be executable multiple times without spawning multiple instances of the same program

# Configure X
wmname LG3D
setxkbmap de -option caps:escape
setup_displays.sh &
libinput-gestures-setup restart &

# Fix spotify
#pulseaudio --kill
#pulseaudio --start
#killall -9 spotify

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
(sleep 2; killall picom; picom --experimental-backends) &
