#!/bin/sh

# Dependencies: dunstify find pandoc

# paths to directories must not be terminated with '/'
csspath="$HOME/.config/assets/notes/style.css"
notepath="$HOME/Documents/Notes"
outpath="$HOME/.cache/Notes"
previewpath="/tmp/Notes"
registerfile="$outpath.reg"

if command -v surf > /dev/null; then
    browser="surf -d"
else
    browser="$BROWSER"
fi

# Follow symlink if notepath is one
if [ -h "$notepath" ]; then
    notepath="$(readlink $notepath)"
fi

escapegrep () {
    echo $1 | sed 's/\././g'
}

registered () {
    [ -f "$registerfile" ] || return 1

    grep " $(escapegrep $1)$" "$registerfile"
}

register () {
    if [ -f "$registerfile" ]; then
        cp "$registerfile" "/tmp/notesregister.sec"
        grep -v " $(escapegrep $1)" "/tmp/notesregister.sec" > "$registerfile"
        echo
    fi

    md5sum $1 | sed 's/  / /' >> "$registerfile"
}

uptodate () {
    query="$(md5sum $1 | sed 's/  / /')"

    registered $1 && grep -F -x "$query" "$registerfile"
}

compile_entry () {
    infile="$(realpath $1)"
    outfile="$(get_outpath $infile)"
    parent="$(dirname $outfile)"

    [ -d "$parent" ] || mkdir -vp "$parent"
    pandoc -f markdown -t html --css="$csspath" -s -o "$outfile" "$infile"
    echo "pwd: $(pwd) ret: $?"
    echo "in: $infile out: $outfile par: $parent"

    # fix links
    sed -i 's/\.md/\.html/g' "$outfile"
}

compile_notes () {
    # make sure the directories are where they should be
    [ -d "$notepath" ] || \
        (echo "You have don't have any notes in $notepath"; exit 1)
    [ -d "$outpath" ] || mkdir -vp "$outpath"

    # convert all markdown file
    for mdfile in $(find $notepath -name "*.md" -type f); do
        if ! uptodate "$mdfile"; then
            compile_entry "$mdfile"
            register "$mdfile"
        else
            echo "Skipping $mdfile (already registered)"
        fi
    done

    # copy images etc along
    for mediafile in $(find $notepath -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.pdf" \)); do
        infile="$mediafile"
        outfile="$(get_outpath $infile)"
        parent="$(dirname $outfile)"

        [ -d "$parent" ] || mkdir -vp "$parent"
        cp -ruva "$infile" "$outfile"
    done
}

get_outpath () {
    infile="$(realpath $1)"
    if echo "$infile" | grep '\.md$' > /dev/null 2>&1; then
        echo "$outpath/$(echo "$infile" | sed 's/^'"$(echo "$notepath" | sed 's/\//\\\//g')"'//;s/\.md$/.html/g')"
    else
        echo "$outpath/$(echo "$infile" | sed 's/^'"$(echo "$notepath" | sed 's/\//\\\//g')"'//')"
    fi
}

preview () {
    # make sure the output directory exists
    [ -d "$previewpath" ] || mkdir -vp "$previewpath"

    infile="$1"
    outfile="$previewpath/$(echo "$infile" | md5sum | cut -f1 -d' ').html"

    pandoc -f markdown -t html --css="$csspath" -s -o "$outfile" "$infile"
    $browser "$outfile"
}


case $1 in
    clean)
        rm -rf "$outpath"
        compile_notes
        ;;
    path)
        echo "$notepath"/
        ;;
    update | compile)
        if [ "$2" = "async" ]; then
            ( (compile_notes > /dev/null 2>&1 \
                && dunstify -a Notes "Successfully compiled your notes") \
                || dunstify -a Notes "An error occured while compiling you notes") &
        else
            compile_notes
        fi
        ;;
    view)
        if [ -z "$2" ]; then
            echo $outpath
            $browser "$outpath"/index.html
        elif realpath "$2" | grep "^$notepath"; then
            compile_notes
            $browser "$(get_outpath "$(realpath $2)")"
        fi
        ;;
    preview)
        preview "$2"
        ;;
    '')
        $EDITOR "$notepath"/index.md
        ;;
    *)
        preview "$1"
        ;;
esac

