#!/bin/sh
# Dependencies: bluetooth.sh ethernet.sh wifi.sh ping sh xmenu


network_menu () {
	menu="  Toggle Wifi	wifi.sh toggle
  Toggle Bluetooth	bluetooth.sh toggle
  Toggle Ethernet	ethernet.sh toggle

  Network Connections	nm-connection-editor
  Bluetooth Settings	blueman-manager"

	echo "$menu" | xmenu | sh
}

case $1 in
	2)
		dunstify -a "PING" -- "Pinging www.wikipedia.org (4 times; IPv4+IPv6)"
		dunstify -a "PING IPv4" -- "$(ping -4 -c 4 www.wikipedia.org | tail -n 3)" &
		dunstify -a "PING IPv6" -- "$(ping -6 -c 4 www.wikipedia.org | tail -n 3)" &
		;;
	3)
		network_menu ;;
esac
