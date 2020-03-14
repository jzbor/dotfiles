#!/bin/sh

if [ "$#" = "0" ]; then
    if iwgetid > /dev/null; then
	echo 直
    elif wifi | grep -q "on"; then
	echo 睊
    else
	echo 
    fi
else
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
	    device_query="$(rfkill --output "ID,TYPE,SOFT,HARD" | \
		grep "wlan" | head -n 1 | \
		sed 's/^\s//g;s/\s\+/ /g')"
	    dev_id="$(echo "$device_query" | cut -d " " -f 1)"
	    dev_soft="$(echo "$device_query" | cut -d " " -f 3)"

	    if [ "$dev_soft" = "unblocked" ]; then
		sudo rfkill block "$dev_id"
	    else
		sudo rfkill unblock "$dev_id"
	    fi
	    ;;
    esac
fi

# On but not connected: 睊


