#! /bin/bash

bspc rule -a \* node="@/2" split_dir="south"
while read -r _; do
    bspc node @/2 -B
done < <(bspc subscribe node_add node_swap node_remove node_geometry)
