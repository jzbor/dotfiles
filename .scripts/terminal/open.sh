#!/bin/sh
# Dependencies: file xdg-open


if [ "$(file -i $1 | cut -d' ' -f2 | sed 's/\/.*//')" = "text" ] \
        || [ "$(file -i $1 | cut -d' ' -f2)" = "inode/x-empty;" ]; then
    $EDITOR "$@"
else
    xdg-open "$@"
fi
