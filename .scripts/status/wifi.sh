#!/bin/sh

device_query="$(rfkill --output "ID,TYPE,SOFT,HARD" | \
    grep "wlan" | head -n 1 | \
    sed 's/^\s//g;s/\s\+/ /g')"
dev_id="$(echo "$device_query" | cut -d " " -f 1)"
dev_soft="$(echo "$device_query" | cut -d " " -f 3)"

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
		if [ "$dev_soft" = "unblocked" ]; then
			nmcli radio wifi off
		else
			nmcli radio wifi on
		fi
	;;
    "on")
		nmcli radio wifi on
		;;
    "off")
		nmcli radio wifi off
		;;
    "status" | "")
		if command -v iwgetid 1>/dev/null 2>/dev/null && iwgetid > /dev/null; then
			echo 直
		elif [ "$dev_soft" = "unblocked" ]; then
			echo 睊
		else
			echo 
		fi
		;;
esac
