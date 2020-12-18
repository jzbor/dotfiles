#!/usr/bin/env sh
# Check dependencies
DEPENDENCIES=""
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


status="$(cat /sys/class/power_supply/AC*/online 2> /dev/null)"

if [ "$status" = "1" ]; then
    echo " ﮣ "
fi

