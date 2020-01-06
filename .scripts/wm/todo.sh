#!/bin/sh

TODO_FILE="$HOME/txtfiles/ToDo.md"
SHOW_FILE="$HOME/.cache/.show_todos"

case "$1" in
    "a" | "append")
	echo "* $2" >> "$TODO_FILE"
	;;
    "h" | "hide")
	rm "$SHOW_FILE"
	;;
    "s" | "show")
	touch "$SHOW_FILE"
	;;
    "t" | "toggle")
	if [ -f "$SHOW_FILE" ]; then
	    rm "$SHOW_FILE"
	else
	    touch "$SHOW_FILE"
	fi
	;;
    "c" | "conky")
	if [ -f "$SHOW_FILE" ]; then
	    cat "$TODO_FILE"
	fi
	;;
    *)
	cat "$TODO_FILE"
	;;
esac
