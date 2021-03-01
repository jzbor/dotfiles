#!/bin/sh
case "$STATUSCMDN" in
    0) tray-options.sh $BUTTON;;
    1) dwmmusic.sh $BUTTON;;
    2) dwmvolume.sh $BUTTON;;
    3) dwmnetwork.sh $BUTTON;;
    4) dwmdate.sh $BUTTON;;
    *) notify-send "out of range"
esac
