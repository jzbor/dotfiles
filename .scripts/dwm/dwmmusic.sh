#!/bin/sh
# Dependencies: music.sh


case $1 in
    1) music.sh play-pause ;;
    2) music.sh previous ;;
    3) music.sh next ;;
esac

