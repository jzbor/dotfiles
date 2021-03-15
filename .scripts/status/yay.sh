#!/bin/sh
# Dependencies: yay


programs="$(yay -Qu 2> /dev/null | wc -l)"

if [ "$programs" -gt 0 ]; then
    echo " $programs Updates "
else
    echo " Up to date "
fi

