#!/bin/sh

(timeout 0.5s i3status 2> /dev/null; echo) | head -n 1 | rofi -sep '|' -dmenu -p 'Status'
