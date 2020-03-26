#! /bin/sh
# @TODO Use findmnt for unmounting

case $1 in
    "mnt")
	operation="mount"
	title="Mount"
	;;
    "umnt")
	operation="unmount"
	title="Unmount"
	;;
    "*" | "")
	echo "Option $1 not available!"
	exit 1
	;;
esac

device=$(lsblk -pln -o SIZE,LABEL,NAME | \
    rofi -dmenu -p "$title" | \
    sed 's/.*\s\w*//g')

response="$(udisksctl "$operation" --block-device "$device" 2>&1)"
dunstify -a "$title" "$response"


