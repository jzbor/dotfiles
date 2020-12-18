#!/bin/sh

# Check dependencies
DEPENDENCIES="xrdb"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


get_xr () {
    xrdb -query -all | grep "$1": | sed "s/.*#/#/g" | tail -n1
}

color_file="$HOME/.config/rofi/colors.rasi"

printf "* {\n" > $color_file
printf "\tbackground:\t\t%s;\n" $(get_xr themeBackground) >> $color_file
printf "\tbackground-trans:\t\t%s;\n" $(get_xr themeBackgroundTrans) >> $color_file
printf "\tforeground:\t\t%s;\n" $(get_xr themeForeground) >> $color_file
printf "\turgent:\t\t%s;\n" $(get_xr themeUrgent) >> $color_file
printf "\tselected:\t\t%s;\n" $(get_xr themeSelector) >> $color_file
printf "}\n" >> $color_file
