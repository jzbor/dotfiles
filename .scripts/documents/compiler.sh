#!/usr/bin/env sh

# This script will compile or run another finishing operation on a document. I
# have this script run via vim.
#
# Compiles .tex. groff (.mom, .ms), .rmd, .md.  Opens .sent files as sent
# presentations.  Runs scripts based on extention or shebang

file=$(readlink -f "$1")
dir=$(dirname "$file")
base="${file%.*}"

cd "$dir" || exit

textype() { \
	#command="pdflatex -interaction=batchmode"
	command="pdflatex"
	( head -n 5 "$file" | grep -i -q 'xelatex' ) && command="xelatex"
	$command --output-directory="$dir" "$base" &&
	( head -n 50 "$file" | grep -i -q 'biber' ) &&
	biber --input-directory "$dir" "$base" &&
	$command --output-directory="$dir" "$base" &&
	$command --output-directory="$dir" "$base"
}

# compile notes
if echo "$file" | grep "^$(notes.sh path)" > /dev/null \
		&& echo "$1" | grep "\.md$"; then
	notes.sh compile
	exit 0
fi

case "$file" in
    *\.ms) refer -PS -e "$file" | groff -me -ms -kept -T pdf > "$base".pdf ;;
    *\.mom) refer -PS -e "$file" | groff -mom -kept -T pdf > "$base".pdf ;;
    *\.[0-9]) refer -PS -e "$file" | groff -mandoc -T pdf > "$base".pdf ;;
    *\.[rR]md) Rscript -e "require(rmarkdown); rmarkdown::render('$file', quiet=TRUE)" ;;
    *\.tex) textype "$file" ;;
    *\.md) pandoc "$file" --pdf-engine=pdflatex -o "$base".pdf ;;
    *config.h) sudo make install ;;
    *\.c) cc "$file" -o "$base" && "$base" ;;
    *\.py) python "$file" ;;
    *\.go) go run "$file" ;;
    *\.sent) setsid sent "$file" 2>/dev/null & ;;
    *\.rs) cargo run ;; #||
        #(echo; echo "--> Cargo not initialized"; echo; rustc "$file" && "$base") ;;
    *) sed 1q "$file" | grep "^#!/" | sed "s/^#!//" | xargs -r -I % "$file" ;;
esac
