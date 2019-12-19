#!/bin/sh

echo "shutdown now
systemctl suspend
lock.sh" | rofi -dmenu | bash
