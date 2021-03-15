#!/bin/sh

# Dependencies: xrdb dunst


get_xr () {
    xrdb -query -all | grep "$1": | sed "s/.*#/#/g" | tail -n1
}

killall -9 dunst

/usr/bin/dunst \
    -lb "$(get_xr themeBackground)" \
    -nb "$(get_xr themeBackground)" \
    -cb "$(get_xr themeBackground)" \
    -lf "$(get_xr themeForeground)" \
    -bf "$(get_xr themeForeground)" \
    -cf "$(get_xr themeForeground)" \
    -nf "$(get_xr themeForeground)" \
    -lfr "$(get_xr themeForeground)" \
    -nfr "$(get_xr themeForeground)" \
    -cfr "$(get_xr themeForeground)" \
    &
