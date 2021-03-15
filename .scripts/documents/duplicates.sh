#!/bin/bash
# From https://www.reddit.com/r/linuxquestions/comments/ham5i6/find_duplicate_files/
# Dependencies: find xargs


find "$1" -type f -print0 |
    xargs -0 stat -c "%012s"$'\t'"%n" |
    sort -k1,1n |
    uniq -w 12 -D |
    cut -f2 |
while read f
do
    md5sum "$f"
done | sort | uniq -w 32 --all-repeated=separate
