#!/bin/sh

dunst.sh
music.sh loop &
# if [ "$REGULAR_PICOM" = 1 ]; then
#     picom --experimental-backends --config ~/.config/picom-basic.conf
# elif [ "$NOPICOM" != 1 ]; then
#     (killall -9 picom-guardian.sh; picom-guardian.sh) &
# fi
# command -v rambox > /dev/null && rambox
# command -v solaar > /dev/null && solaar -w hide &
