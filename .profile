#!/bin/sh

export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"
export READER="zathura"
export FILEMANAGER="pcmanfm"
export DMENUCMD="wmc-utils drun"
# export LANG="en_US.UTF-8"

if command -v alacritty > /dev/null; then
	export TERMINAL="alacritty"
else
	export TERMINAL="uxterm"
fi

# monwm
MOONWM_STATUSCMD="dwmstatus.sh"
MOONWM_KEYMAP="us,de -option -option caps:escape_shifted_capslock -option altwin:swap_alt_win -option grp:lwin_switch"
MOONWM_PICOM=0

# For compatibility between gtk icon themes and qt
export DESKTOP_SESSION=gnome

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
export PATH="$PATH:$HOME/.local/bin:$($HOME/.scripts/path.sh)"
export PATH="$PATH:/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

export BUILD_PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"


command -v hub && eval "$(hub alias -s)"

# Define host color code => different color for each system (up to 8)
export HOSTCC="$(printf "\e[0;%sm" \
	"$(printf "obase=16; (%s + 8) %% 6 + 2; obase=10; . + 30\n" \
	    "$(< /etc/hostname | md5sum | head -c 1)" \
    | bc | tail -n 1)")"
export HOSTCC_ZSH="$(printf "%s" \
	"$(printf "obase=16; (%s + 8) %% 6 + 2; obase=10\n" \
	    "$(< /etc/hostname | md5sum | head -c 1)" \
    | bc | tail -n 1)")"

[ -f "$HOME/.profile.local" ] && . .profile.local


# Automatically start dwm
if [ -f "$HOME/.config/session" ] \
        && [ -z $DISPLAY ] && [ $TTY = /dev/tty1 ]; then
    exec startx ~/.xinitrc "$(cat $HOME/.config/session)"
fi
