#!/bin/bash

shopt -s nullglob globstar

menu="New
Copy
Paste
Show
Edit"

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

random_password () {
    tr -cd '[:alnum:]' < /dev/urandom | fold -w16 | head -n 1
}

new_password () {
    name="$(echo | dmenu -p Name:)"
    password="$(random_password | dmenu -p Password)"
    echo "$password" | pass insert -m "$name"
    pass show -c "$name"
}

copy_password () {
    pass show -c "$password" 2> /dev/null
}

paste_password () {
	pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } |
		xdotool type --clearmodifiers --file -
}

show_password () {
    pass show "$password" | dmenu -p "$password: " "$@" > /dev/null
}

edit_password () {
    $TERMINAL -e "pass" edit "$password"
}


case $1 in
    new | copy | paste | show | edit)
        action="${1^}"
        shift
        ;;
    *)
        action="$(echo "$menu" | dmenu -i -p pass "$@")" ;;
esac


case $action in
    Copy | Paste | Show | Edit)
        password=$(printf '%s\n' "${password_files[@]}" | dmenu "$@")
        [ -n "$password" ] || exit 1
        ;;
    "")
        exit 1;;
esac


case $action in
    New) new_password;;
    Copy) copy_password;;
    Paste) paste_password;;
    Show) show_password;;
    Edit) edit_password;;
esac


