#!/bin/sh

echo "shutdown now
systemctl suspend
lock.sh
i3-msg exit" | rofi -dmenu | bash
