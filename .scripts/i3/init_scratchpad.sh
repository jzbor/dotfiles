#!/bin/sh

command -v kitty && \
    ( nice -n -9 kitty -T scratchterm &
	nice -n -8 kitty -T taskmgr -e htop & )
