#!/bin/sh

BG_DIR="$HOME/.config/assets"
BG_SYMLN="$BG_DIR/background"
alias config=
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

case $1 in
    '')
	case $TERM in
	    *kitty)
		kitty icat
		;;
	esac
	echo "Current background: $(readlink -f $BG_SYMLN)"
	;;
    load)
	[ -h $BG_SYMLN ] || (echo "Background symlink is missing"; exit 1)
	xwallpaper --zoom $BG_SYMLN
	;;
    *)
	[ -f $1 ] || (echo "There is no such file: $1"; exit 1)

	echo "Cleaning up old background:"
	echo "    -> rm $(readlink -f $BG_SYMLN)"
	config rm -f "$(readlink -f $BG_SYMLN)" && echo "    -> Removed files from config repository" \
	    || rm "$(readlink -f $BG_SYMLN)"
	echo "Creating copy of new background: $BG_DIR/$(basename $1)"
	cp $1 $BG_DIR/$(basename $1)
	echo "Resetting symlink"
	ln -sf "$BG_DIR/$(basename $1)" $BG_SYMLN
	echo "Updating wallpaper in current session"
	xwallpaper --zoom $BG_SYMLN
	echo "Adding changes to config repo (staging)"
	config add $BG_SYMLN $(readlink -f $BG_SYMLN)
	;;
esac

