#!/bin/sh

for dep in $DEPENDENCIES; do
	if ! command -v "$dep" > /dev/null 2>&1; then
		echo "$0 is missing the programm: $dep" 1>&2
		[ -f "~/.config/checkdeps-notifications" ] && command -v dunstify > /dev/null 2>&1 \
			&& dunstify -a checkdeps "The script $0 is missing the programm: $dep"
	fi
done
