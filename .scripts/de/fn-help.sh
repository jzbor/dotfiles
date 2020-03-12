/bin/sh

dunstify -a "Fn Keys:" "$(bash -c 'cat ~/.config/i3/config | grep -A 11 --color=never "bindsym \$mod+F1 exec" | sed "s/ exec//g; s/bindsym \$mod+//g; s/ /\t\t\t/"')"
