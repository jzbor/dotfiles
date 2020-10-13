#!/bin/sh

# Applications			rofi -show drun

cache_file="/tmp/xdg-xmenu-cache"

[ -f "$cache_file" ] || (xdg-xmenu > $cache_file)

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
$(sed -e 's/^/	/' $cache_file)

Menu					menu.sh
System Menu				menu.sh system
Power Menu
	  Shutdown			sudo poweroff
	  Reboot			sudo reboot
	  Log out			pkill -15 -t tty\"$XDGVTNR\" Xorg"

echo "$menu" | xmenu | sh

# Generate cache
pgrep xdg-xmenu || xdg-xmenu > "$cache_file.sec"
mv "$cache_file.sec" "$cache_file"
