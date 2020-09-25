#!/bin/sh

csspath="$HOME/.config/assets/notes/style.css"
notepath="$HOME/Documents/Notes/"
outpath="$HOME/.cache/Notes/"
previewpath="/tmp/Notes/"

compile_entry () {
    infile="$1"
    outfile="$(get_outpath $infile)"
    parent="$(dirname $outfile)"

    [ -d "$parent" ] || mkdir -vp "$parent"
    pandoc -f markdown -t html --css="$csspath" -s -o "$outfile" "$infile"
    echo $outfile
}

compile_notes () {
    # make sure the directories are where they should be
    [ -d "$notepath" ] || \
        (echo "You have don't have any notes in $notepath"; exit 1)
    [ -d "$outpath" ] || mkdir -vp "$outpath"

    # convert all markdown file
    for mdfile in $(find $notepath -name "*.md" -type f); do
        compile_entry "$mdfile"
    done

    # copy images etc along
    for mediafile in $(find $notepath -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \)); do
        infile="$mediafile"
        outfile="$(get_outpath $infile)"

        cp -ruva "$infile" "$outfile"
    done

    # fix links
    find "$outpath" -name "*.html" -exec sed -i 's/\.md/\.html/g' {} +
}

get_outpath () {
    infile="$1"
    if echo "$infile" | grep '\.md$' > /dev/null 2>&1; then
        echo "$outpath$(echo "$1" | sed 's/^'"$(echo "$notepath" | sed 's/\//\\\//g')"'//;s/\.md$/.html/g')"
    else
        echo "$outpath$(echo "$1" | sed 's/^'"$(echo "$notepath" | sed 's/\//\\\//g')"'//')"
    fi
}

preview () {
    # make sure the output directory exists
    [ -d "$previewpath" ] || mkdir -vp "$previewpath"

    infile="$1"
    outfile="$previewpath$(echo "$infile" | md5sum | cut -f1 -d' ').html"

    pandoc -f markdown -t html --css="$csspath" -s -o "$outfile" "$infile"
    $BROWSER "$outfile"
}


case $1 in
    clean)
        rm -rf "$notepath"
        compile_notes
        ;;
    path)
        echo "$notepath"
        ;;
    test)
        get_outpath "$2"
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
            $BROWSER "$outpath"index.html
        elif echo "$2" | grep "^$notepath"; then
            compile_entry "$2"
            $BROWSER "$(get_outpath $2)"
        fi
        ;;
    preview)
        preview "$2"
        ;;
    *)
        preview "$1"
        ;;
esac

