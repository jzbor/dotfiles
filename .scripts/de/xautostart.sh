#!/bin/sh

# This script has to be executable multiple times without spawning multiple instances of the same program

# Configure X
wmname LG3D
setxkbmap de -option caps:escape
libinput-gestures-setup restart &
setup_displays.sh &

# Configure touchscreen on T440
[ "$(hostname)" = "T440" ] && xinput --map-to-output 'ELAN Touchscreen' eDP-1

# Start pulseaudio if installed
command -v pulseaudio && pulseaudio --start

# Daemons that automatically check for running instances
/usr/lib/kdeconnectd &
/usr/lib/geoclue-2.0/demos/agent &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
music.sh loop &

# Other daemons
dunst.sh &

# Applications
nextcloud --background &
spicetify update &

# Applets & tray icons
nm-applet &
xfce4-power-manager &
(killall clipit; clipit) &
(killall redshift-gtk; redshift-gtk) &

# Start compositor
(sleep 2; killall picom; picom --experimental-backends) &
