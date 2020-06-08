#! /bin/sh

if [ "$1" = '' ]; then
    echo Usage: $1 list1 [ list2 ... ]
    exit
fi

echo
echo "### Installing yay, base-devel group and system updates###"
echo
if command -v yay > /dev/null; then
    yay -Syu base-devel --needed
else
    sudo pacman -Syu yay base-devel --needed
fi

echo
echo "### Installing packages ###"
echo

cd "$(dirname $0)"

for list in $@; do
    if ! [ -f "$list" ]; then
	echo Error: Couldn\'t find list \"$list\"!
	exit 1
    fi
done

yay -S --needed $(cat $(echo $@ | sed "s/$(basename $0)//") | sed '/#.*/d;/^$/d' | tr '\n' ' ')
