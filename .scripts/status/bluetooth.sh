#!/bin/sh

if [ "$#" = "0" ]; then
    if bluetooth | grep -q " on"; then
	echo 
    else
	echo 
    fi
else
    case "$1" in
	"toggle")
	    device_query="$(rfkill --output "ID,TYPE,SOFT,HARD" | \
		grep "bluetooth" | head -n 1 | \
		sed 's/^\s//g;s/\s\+/ /g')"
	    dev_id="$(echo "$device_query" | cut -d " " -f 1)"
	    dev_soft="$(echo "$device_query" | cut -d " " -f 3)"

	    if [ "$dev_soft" = "unblocked" ]; then
		sudo rfkill block "$dev_id"
	    else
		sudo rfkill unblock "$dev_id"
	    fi
	    # if (rfkill --output-all -n | grep "tpacpi_bluetooth_sw" > /dev/null); then; fi

	    ;;
	"*")
	    ;;
    esac
fi

# On but not connected 

