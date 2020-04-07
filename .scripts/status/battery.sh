#!/bin/sh

get_icon () {
    case $3 in
	Charging)
	    echo 
	    ;;
	Discharging | "Not charging" | Unknown)
	    let "level = $1 / (100 / 5)"
	    case $level in
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
		"*" | "")
		    echo $level
		    ;;
	    esac
	    return
	    ;;
	"*" | "")
	    echo $3
	    ;;
    esac
}

for battery in $(eval echo /sys/class/power_supply/BAT?); do
    capacity=$(cat $battery/capacity)
    charge_stop_threshold=$(cat $battery/charge_stop_threshold)
    bat_status=$(cat $battery/status)
    printf "%s  %s " $(get_icon $capacity $charge_stop_threshold $bat_status) $capacity%
done

for other in $(ls /sys/class/power_supply/ | grep -v 'BAT\?'); do
    [ "$(cat /sys/class/power_supply/$other/online)" -eq 1 ] && printf " " || printf ""
done
