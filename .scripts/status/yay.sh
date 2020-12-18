#!/bin/sh
# Check dependencies
DEPENDENCIES="yay"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


programs="$(yay -Qu 2> /dev/null | wc -l)"

if [ "$programs" -gt 0 ]; then
    echo " $programs Updates "
else
    echo " Up to date "
fi

