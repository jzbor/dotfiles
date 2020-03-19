#!/usr/bin/env sh

status="$(cat /sys/class/power_supply/AC*/online 2> /dev/null)"

if [ "$status" = "1" ]; then
    echo " ﮣ "
fi

