#!/bin/sh
# Check dependencies
DEPENDENCIES="music.sh"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


case $1 in
    1) music.sh play-pause ;;
    2) music.sh previous ;;
    3) music.sh next ;;
esac

