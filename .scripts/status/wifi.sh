#!/bin/sh

if [ "$1" = "notify" ]; then
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
else
    if iwgetid > /dev/null; then
	echo 直
    elif wifi | grep -q "on"; then
	echo 睊
    else
	echo 
    fi
fi

# On but not connected: 睊


