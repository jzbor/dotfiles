#!/bin/sh
# This script has to be executable multiple times without spawning multiple instances of the same program
# Check dependencies
DEPENDENCIES="dunst.sh music.sh setup_displays.sh sxhkd /usr/lib/polkit-gnome/polkit-gnome-authenication-agent-1"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


# Configure X
xrdb -merge ~/.Xresources
wmname LG3D
keyboard.sh de
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
	killall -9 redshift; redshift -x; redshift -l 49:11) &

# Start compositor
(killall -9 picom-guardian.sh; [ "$1" != "nopicom" ] && picom-guardian.sh) &

# In winter it snows...
if [ "$(date +%m)" = 12 ]; then
	killall -9 xsnow
	sleep 1
	xsnow -notrees -nowind
fi &

# libinput-gestures-setup restart &
touchegg --daemon &
touchegg &

# reset keyboard map
keyboard.sh us
