#!/bin/sh

# Check dependencies
DEPENDENCIES="pgrep sh xdg-xmenu xmenu"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


cache_file="/tmp/xdg-xmenu-cache"

generate_cache () {
	if ! [ -f "$cache_file.part" ]; then
		xdg-xmenu > "$cache_file.part"
		mv "$cache_file.part" "$cache_file"
	fi
}

[ -f "$cache_file" ] || generate_cache

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
pgrep xdg-xmenu || generate_cache
