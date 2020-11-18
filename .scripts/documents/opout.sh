#!/usr/bin/env sh
# opout: "open output": A general handler for opening a file's intended output.
# I find this useful especially running from vim.

basename="$(echo "$1" | sed 's/\.[^\/.]*$//')"

# treat notes
if realpath "$1" | grep "^$(notes.sh path)" > /dev/null 2>&1 \
		&& echo "$1" | grep "\.md$"; then
	notes.sh view "$1" > /dev/null
	exit 0
fi

case "$1" in
    *.md) notes.sh preview "$1";;
    *.tex|*.rmd|*.ms|*.me|*.mom) setsid "$READER" "$basename".pdf >/dev/null 2>&1 & ;;
    *.html) setsid "$BROWSER" --new-window "$basename".html >/dev/null 2>&1 & ;;
    *.sent) setsid sent "$1" >/dev/null 2>&1 & ;;
esac
