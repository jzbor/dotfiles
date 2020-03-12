#!/bin/bash

get_xr () {
    xrdb -query -all | grep "$1": | sed "s/.*#/#/g" | tail -n1
}

extract_color () {
    echo "$1" | sed 's/,//g' | cut --delimiter " " --fields "$2"
}

color_window_bg="$(extract_color "$(get_xr color-window)" 1)"
color_window_border="$(extract_color "$(get_xr color-window)" 2)"
color_window_seperator="$(extract_color "$(get_xr color-window)" 3)"

color_normal_bg="$(extract_color "$(get_xr color-normal)" 1)"
color_normal_fg="$(extract_color "$(get_xr color-normal)" 2)"
color_normal_bgalt="$(extract_color "$(get_xr color-normal)" 3)"
color_normal_hlbg="$(extract_color "$(get_xr color-normal)" 4)"
color_normal_hlfg="$(extract_color "$(get_xr color-normal)" 5)"

color_urgent_bg="$(extract_color "$(get_xr color-urgent)" 1)"
color_urgent_fg="$(extract_color "$(get_xr color-urgent)" 2)"
color_urgent_bgalt="$(extract_color "$(get_xr color-urgent)" 3)"
color_urgent_hlbg="$(extract_color "$(get_xr color-urgent)" 4)"
color_urgent_hlfg="$(extract_color "$(get_xr color-urgent)" 5)"

color_active_bg="$(extract_color "$(get_xr color-active)" 1)"
color_active_fg="$(extract_color "$(get_xr color-active)" 2)"
color_active_bgalt="$(extract_color "$(get_xr color-active)" 3)"
color_active_hlbg="$(extract_color "$(get_xr color-active)" 4)"
color_active_hlfg="$(extract_color "$(get_xr color-active)" 5)"

modi="$(get_xr modi)"
font="$(get_xr font)"
terminal="$(get_xr font)"

export color_window_bg
export color_window_border
export color_window_seperator

export color_normal_bg
export color_normal_fg
export color_normal_bgalt
export color_normal_hlbg
export color_normal_hlfg

export color_urgent_bg
export color_urgent_fg
export color_urgent_bgalt
export color_urgent_hlbg
export color_urgent_hlfg

export color_active_bg
export color_active_fg
export color_active_bgalt
export color_active_hlbg
export color_active_hlfg

export modi
export font
export terminal


rofi "$@"
