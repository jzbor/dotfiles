#!/bin/sh

get_icon () {
    let "step = $2 / 5"
    for i in 4 3 2 1 0 ; do
	let "level = $step * i"
	if [ $1 -gt $level ]; then
	    case $i in
		0)
		    echo 
		    ;;
		1)
		    echo 
		    ;;
		2)
		    echo 
		    ;;
		3)
		    echo 
		    ;;
		4) echo
		    echo 
		    ;;
	    esac
	    return
	fi
    done
}

status_string=""
for battery in $(eval echo /sys/class/power_supply/BAT?); do
    capacity=$(cat $battery/capacity)
    charge_stop_threshold=$(cat $battery/charge_stop_threshold)
    status_string=$(printf "%s %s %s" $status_string $(get_icon $capacity $charge_stop_threshold) $capacity%)
done

echo $status_string
