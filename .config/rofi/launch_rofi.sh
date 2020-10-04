#!/bin/bash

get_xr () {
    xrdb -query -all | grep "$1": | sed "s/.*#/#/g" | tail -n1
}

extract_color () {
    echo "$1" | sed 's/,//g' | cut --delimiter " " --fields "$2"
}

THEMEFG="$(get_xr themeForeground)"
THEMEBG="$(get_xr themeBackground)"
THEMESEL="$(get_xr themeSelector)"
THEMEURG="$(get_xr themeUrgent)"

MODI="$(get_xr modi)"
FONT="$(get_xr font)"
TERMINAL="$(get_xr font)"

export THEMEBG
export THEMEFG
export THEMESEL
export THEMEURG

export MODI
export FONT
export TERMINAL


rofi -config ~/.config/rofi/myconfig.rasi "$@"
