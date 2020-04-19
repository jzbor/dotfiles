#!/bin/sh

command -v kitty && \
    ( nice -n -9 kitty -T scratchterm &
	nice -n -8 kitty -T taskmgr -e htop &
	sleep 2.0;
	i3-msg move scratchpad;
	i3-msg move scratchpad) &> $HOME/debug
