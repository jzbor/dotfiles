#!/bin/sh

export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"
export READER="zathura"
command -v alacritty > /dev/null && export TERM="alacritty" || export TERM="xterm-256color"
export TERMINAL="alacritty"
export FILEBROWSER="pcmanfm"


export QT_QPA_PLATFORMTHEME="qt5ct"

# XDG base dir support
eval $(sed 's/#.*//;/^$/ d;s/^/export /' .config/user-dirs.dirs)

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export LESSHISTFILE="-"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"


# fix "xdg-open fork-bomb" export your preferred browser from here
export PATH="$PATH:$HOME/.local/bin/tools:$HOME/.local/bin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$($HOME/.scripts/path.sh)"

export BUILD_PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"


command -v hub && eval "$(hub alias -s)"

# Define host color code => different color for each system (up to 8)
export HOSTCC="$(printf "\e[0;%sm" \
	"$(printf "obase=16; (%s + 8) %% 6 + 2; obase=10; . + 30\n" \
	    "$(hostname | md5sum | head -c 1)" \
    | bc | tail -n 1)")"
export HOSTCC_ZSH="$(printf "%s" \
	"$(printf "obase=16; (%s + 8) %% 6 + 2; obase=10\n" \
	    "$(hostname | md5sum | head -c 1)" \
    | bc | tail -n 1)")"


# Automatically start dwm
if ! command -v lightdm gdm > /dev/null \
	&& [ -z $DISPLAY ] && [ $TTY = /dev/tty1 ]; then
    if command -v dwm > /dev/null; then
	exec startx ~/.xinitrc dwm
    elif command -v i3 > /dev/null; then
	exec startx ~/.xinitrc i3
    fi
fi

