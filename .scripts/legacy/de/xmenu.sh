#!/bin/sh

# Check dependencies
DEPENDENCIES="pgrep sh xdg-xmenu xmenu"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


menu="  Fullscreen		dwmc togglefullscr
  Floating			dwmc togglefloating
  Zoom				dwmc zoom
  Close			dwmc killclient

Menu					menu.sh
System Menu				menu.sh system"

echo "$menu" | xmenu | sh

xdg-xmenu -u &
