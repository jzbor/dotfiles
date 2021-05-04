#!/bin/sh

file=$(readlink -f "$1")
dir=$(dirname "$file")
base="${file%.*}"
fout="$2"

pandoc "$file" --pdf-engine=pdflatex -o "$base"."$fout"
