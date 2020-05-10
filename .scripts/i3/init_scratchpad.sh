#!/bin/sh

command -v alacritty && \
    ( nice -n 9 alacritty -t scratchterm &
	nice -n -8 alacritty -t taskmgr -e htop & ) \
|| command -v kitty && \
    ( nice -n -9 kitty -T scratchterm &
	nice -n -8 kitty -T taskmgr -e htop & )
