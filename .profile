#!/bin/sh

export EDITOR="nvim"
export VISUAL="$EDITOR"
export KEYLAYOUT='QWERTZ-HJKL'
export BROWSER="firefox"
export READER="zathura"
export TERM="xterm-256-color"
export TERMINAL="alacritty"
export FILEBROWSER="pcmanfm"


export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# fix "xdg-open fork-bomb" export your preferred browser from here
export PATH="$PATH:/
    $HOME/.local/bin/tools:\
    $HOME/.local/bin/:\
    $HOME/.local/bin:\
    /usr/local/bin:\
    /usr/bin:/bin:\
    /usr/local/sbin:\
    /usr/lib/jvm/default/bin:\
    /usr/bin/site_perl:\
    /usr/bin/vendor_perl:\
    /usr/bin/core_perl:\
    $($HOME/.scripts/path.sh)"

export BUILD_PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"


eval "$(hub alias -s)"

# Define host color code => different color for each system (up to 8)
export HOSTCC="$(printf "\e[0;%sm" \
	"$(printf "obase=16; (%s + 8) %% 6 + 2; obase=10; . + 30\n" \
	    "$(hostname | md5sum | head -c 1)" \
    | bc | tail -n 1)")"
export HOSTCC_ZSH="$(printf "%s" \
	"$(printf "obase=16; (%s + 8) %% 6 + 2; obase=10\n" \
	    "$(hostname | md5sum | head -c 1)" \
    | bc | tail -n 1)")"
