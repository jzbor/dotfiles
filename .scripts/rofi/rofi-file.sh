#!/bin/sh
# Check dependencies
DEPENDENCIES="dunstify rofi fd"
command -v checkdeps.sh > /dev/null 2>&1 && . checkdeps.sh


menu="‭ﱮ    Filebrowser
    Send to Phone
ﬓ    Open
秊    Share"

file="$1"
[ -z "$file" ] && \
    file="$(fd . ~ -t file | rofi -dmenu -i -p 'Select file: ')"

if ! [ -f "$file" ]; then
    echo "File '$file' not found"
    exit
fi

option="$(echo "$menu" | rofi -dmenu -i -p "$file: ")"

case $option in
    *Filebrowser)
        [ -n "$FILEBROWSER" ] && $FILEBROWSER $file
        ;;
    *Phone)
        command -v phone > /dev/null 2>&1 && phone --share $file
        ;;
    *Open)
        xdg-open $file
        ;;
    *Share)
        url="$(curl -F"file=@$file" https://0x0.st)"
        echo "$url" | xclip -selection clipboard
        echo "Shared '$file' via 0x0.st."
        echo "Copied url to clipboard ($url)."
        dunstify -a "0x0.st" "Shared '$file' via 0x0.st and copied link to clipboard. URL: $url"
        ;;
esac

