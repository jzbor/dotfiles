#!/bin/sh

case $1 in
    1) dunstify -a "$(date)" "$(cal)" ;;
    2) setsid xclock ;;
esac
