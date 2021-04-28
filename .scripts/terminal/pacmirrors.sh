#!/bin/sh

praefix="\e[0;94m==="
suffix="===\e[0m\n"

TEMP_MIRRORLIST="${TEMP:-/tmp}/pacmirrorlist"

print_mirrorlist () {
    printf "$praefix Your mirrorlist: $suffix\n"
    cat "$TEMP_MIRRORLIST.fastest"
}

manjaro () {
    printf "$praefix Running Manjaro's pacman-mirrors $suffix"
    sudo pacman-mirrors --fasttrack || exit 1
}

regular () {
    printf "$praefix Downloading mirrorlist ($DISTRO) $suffix"
    curl -o "$TEMP_MIRRORLIST" "$MIRRORURL" || exit 1

    printf "$praefix Preparing mirrorlist $suffix"
    sed -i 's/#S/S/g' "$TEMP_MIRRORLIST" || exit 1

    printf "$praefix Ranking mirrors $suffix"
    rankmirrors "$TEMP_MIRRORLIST" > "$TEMP_MIRRORLIST.fastest" || exit 1

    printf "$praefix Replace current mirrorlist? $suffix"
    read -p "(y/N) " answer
    case $answer in
        y | Y | yes | Yes) ;;
        *) print_mirrorlist; exit ;;
    esac
    sudo mv -v "$TEMP_MIRRORLIST.fastest" /etc/pacman.d/mirrorlist || exit 1
}

DISTRO="$(uname -r | sed 's/.*-//')"
case $DISTRO in
    MANJARO) manjaro ;;
    ARCH) MIRRORURL="https://www.archlinux.org/mirrorlist/all"; regular ;;
    ARTIX) MIRRORURL="https://gitea.artixlinux.org/packagesA/artix-mirrorlist/raw/branch/master/trunk/mirrorlist"; regular ;;
    *)
        echo "$DISTRO is currently not supported"
        exit 1
        ;;
esac

printf "$praefix Update Pacman database and packages $suffix"
sudo pacman -Syyu
