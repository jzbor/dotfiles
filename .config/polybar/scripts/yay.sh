#!/usr/bin/env sh

programs="$(yay -Qu 2> /dev/null | wc -l)"

if (( $programs > 0 )); then
    echo " $programs Updates "
else
    echo " Up to date "
fi

