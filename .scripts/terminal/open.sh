#!/bin/sh
# Check dependencies
DEPENDENCIES="file xdg-open"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


if [ "$(file -i $1 | cut -d' ' -f2 | sed 's/\/.*//')" = "text" ] \
        || [ "$(file -i $1 | cut -d' ' -f2)" = "inode/x-empty;" ]; then
    $EDITOR "$@"
else
    xdg-open "$@"
fi
