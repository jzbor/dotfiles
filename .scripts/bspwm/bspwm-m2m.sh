#!/bin/sh

### MOVE 2 MONITOR ###

source_id=$(bspc query -D -d focused)
n_source=$1 # Workspace number (between 1 and 20)

if [ "$n_source" -le 10 ]; then
    n_target=$((n_source + 10))
elif [ "$n_source" -le 20 ]; then
    n_target=$((n_source - 10))
else
    echo "Workspace number has to be between 1 and 20: $n_source"
fi

source_name="$(bspc query -D --names -d ^$n_source)"
target_name="$(bspc query -D --names -d ^$n_target)"

echo "Source: ^$n_source $source_name"
echo "Target: ^$n_target $target_name"

if [ "$(bspc query -N -d ^$n_target | wc -l)" = "0" ]; then
    #bspc desktop -r ^$n_target
    #bspc desktop -m next --follow
    #bspc desktop -n $target_name $source_name
    #bspc desktop -a

    bspc desktop $source_name --swap $target_name

    sleep 0.2

    bspc monitor ^1 -d I II III IV V VI VII VIII IX X
    bspc monitor ^2 -d XI XII XIII XIV XV XVI XVII XVIII XIX
    bspc desktop ^$n_source -a last

fi
