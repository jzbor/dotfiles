#!/bin/sh

# Assuming there is only one ethernet device
device_query="$(ip link show | \
    grep '^.:\s\(enp[0-9]s[0-9]*\|eth[0-9]\|eno[0-9]\)' |\
    head -n 1)"
dev_id="$(echo "$device_query" | cut -d " " -f 2)"
dev_state="$(echo "$device_query" | cut -d " " -f 9)"

case "$1" in
    "notify")
	ssid="$(iwgetid -r)"
	localip="$(ip addr | grep "inet " | awk '{print "\t" $2 "\t\t(" $(NF) ")"}')"
	publicip="$(curl ifconfig.me)"

	if [ "$ssid" = "" ]; then
	    ssid="Not Connected"
	fi

	dunstify -a "Network Info" "Wifi: $ssid

	Local:
	$localip

	Public:
	    $publicip"
	;;
    "toggle")
	if [ "$dev_state" = "UP" ]; then
	    sudo ip link set "$dev_id" down
	else
	    sudo ip link set "$dev_id" up
	fi
	;;
    "on")
	sudo ip link set "$dev_id" up
	;;
    "off")
	sudo ip link set "$dev_id" down
	;;
    "status" | "")
	if [ "$dev_state" = "UP" ]; then
	    echo 
	elif [ "$dev_state" = "DOWN" ]; then
	    echo 
	else
	    echo 
	fi
	;;
esac
