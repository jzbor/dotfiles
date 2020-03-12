#!/bin/sh

echo "Autostart for ws $1."

query_2="firefox"
query_3="firefox"
query_5="*"
query_9="Thunderbird"

command_2="firefox"
command_3="firefox"
command_5="printf "Kitty\nPyCharm\nIdea\nAndroid-Studio" | rofi -dmenu | tr '[:upper:]' '[:lower:]' | bash"
command_9="thunderbird"


qry_var="query_${1}"
cmd_var="command_${1}"
qry="$(eval echo \$${qry_var})"
cmd="$(eval echo \$${cmd_var})"

case "$XDG_SESSION_DESKTOP" in
    "bspwm")
        (bspc query -d "^1:^$1" -T; bspc query -d "^2:^$1" -T) | grep $qry > /dev/null
        if [ "$?" != "0" ]; then
            $cmd;
        fi;
	;;
esac

