#!/bin/sh

export EDITOR="vim"
export BROWSER="firefox"
export READER="zathura"
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export PATH="$HOME/.local/bin/tools:\
    $HOME/.local/bin/:\
    $HOME/.local/bin:\
    /usr/local/bin:\
    /usr/bin:/bin:\
    /usr/local/sbin:\
    /usr/lib/jvm/default/bin:\
    /usr/bin/site_perl:\
    /usr/bin/vendor_perl:\
    /usr/bin/core_perl:\
    $HOME/.scripts"

eval "$(hub alias -s)"

[[ -f ~/.bashrc ]] && . ~/.bashrc
