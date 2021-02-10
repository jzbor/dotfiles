#!/bin/sh

# Check dependencies
DEPENDENCIES="pgrep sh xdg-xmenu xmenu"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


menu="DWM
	  Fullscreen		dwmc togglefullscr
	  Floating			dwmc togglefloating
	  Zoom				dwmc zoom
	  Close			dwmc killclient

Favourites
	  Terminal			$TERMINAL
	  Web				$BROWSER
	  Media			mpv
	  Mail				thunderbird
	  Files			$FILEBROWSER
Applications			notify-send test
$(xdg-xmenu | sed -e 's/^/	/')

Menu					menu.sh
System Menu				menu.sh system
Power Menu
	  Shutdown			poweroff || sudo poweroff
	  Reboot			reboot || sudo reboot
	  Log out			pkill -15 -t tty\"$XDGVTNR\" Xorg"

echo "$menu" | xmenu | sh

xdg-xmenu -u &
