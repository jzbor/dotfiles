#!/bin/sh

pkill -USR1 status.sh &

case "$STATUSCMDN" in
    0) tray-options.sh $BUTTON;;
    2) dwmmusic.sh $BUTTON;;
    3) dwmvolume.sh $BUTTON;;
    4) dwmnetwork.sh $BUTTON;;
    5) dwmdate.sh $BUTTON;;
    *) notify-send "out of range ($STATUSCMDN)"
esac

