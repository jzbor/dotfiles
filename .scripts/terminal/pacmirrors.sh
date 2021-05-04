#!/bin/sh

praefix="\n\e[0;94m==="
suffix="===\e[0m\n"

TEMP_MIRRORLIST="${TEMP:-/tmp}/pacmirrorlist"

manjaro () {
    printf "$praefix Running Manjaro's pacman-mirrors $suffix"
    sudo pacman-mirrors --fasttrack || exit 1
}

regular () {
    printf "$praefix Downloading mirrorlist [$NAME: $REPOSITORY] $suffix"
    echo "Downloading from $MIRRORURL"
    curl -o "$TEMP_MIRRORLIST" "$MIRRORURL" || exit 1
    sed -i 's/#S/S/g' "$TEMP_MIRRORLIST" || exit 1

    printf "$praefix Ranking mirrors $suffix"
    echo "This may take some while..."
    echo
    if [ "$REPOSITORY" = "arch" ]; then
        rankmirrors-arch -v "$TEMP_MIRRORLIST" | tee "$TEMP_MIRRORLIST.fastest" || exit 1
    else
        rankmirrors -v "$TEMP_MIRRORLIST" | tee "$TEMP_MIRRORLIST.fastest" || exit 1
    fi

    printf "$praefix Replace current mirrorlist? $suffix"
    read -p "(y/N) " answer
    case $answer in
        y | Y | yes | Yes) ;;
        *) exit ;;
    esac
    sudo mv -v "$TEMP_MIRRORLIST.fastest" "${DEST:-/etc/pacman.d/mirrorlist}" || exit 1
}

if [ -f "/etc/os-release" ]; then
    . /etc/os-release
else
    echo "No OS information available" > /dev/stderr
    exit 1
fi

REPOSITORY="$ID"

case $ID in
    manjaro)
        manjaro
        ;;
    artix)
        MIRRORURL="https://gitea.artixlinux.org/packagesA/artix-mirrorlist/raw/branch/master/trunk/mirrorlist"
        regular
        REPOSITORY="arch"
        MIRRORURL="https://archlinux.org/mirrorlist/all/https/"
        DEST="${DEST:-/etc/pacman.d/mirrorlist}-arch"
        regular
        ;;
    arch)
        MIRRORURL="https://archlinux.org/mirrorlist/all/https/"
        regular
        ;;
    *)
        echo "Your distro seems to not be supported ($NAME)" > /dev/stderr
        exit 1
        ;;
esac

printf "$praefix Update Pacman database and packages $suffix"
sudo pacman -Syyu
