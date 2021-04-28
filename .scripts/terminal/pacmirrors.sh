#!/bin/sh

praefix="\n\e[0;94m==="
suffix="===\e[0m\n"

TEMP_MIRRORLIST="${TEMP:-/tmp}/pacmirrorlist"

manjaro () {
    printf "$praefix Running Manjaro's pacman-mirrors $suffix"
    sudo pacman-mirrors --fasttrack || exit 1
}

regular () {
    printf "$praefix Downloading mirrorlist [$DISTRO] $suffix"
    echo "Downloading from $MIRRORURL"
    curl -o "$TEMP_MIRRORLIST" "$MIRRORURL" || exit 1
    sed -i 's/#S/S/g' "$TEMP_MIRRORLIST" || exit 1

    printf "$praefix Ranking mirrors $suffix"
    echo "This may take some while..."
    echo
    rankmirrors -v "$TEMP_MIRRORLIST" | tee "$TEMP_MIRRORLIST.fastest" || exit 1

    printf "$praefix Replace current mirrorlist? $suffix"
    read -p "(y/N) " answer
    case $answer in
        y | Y | yes | Yes) ;;
        *) exit ;;
    esac
    sudo mv -v "$TEMP_MIRRORLIST.fastest" "${DEST:-/etc/pacman.d/mirrorlist}" || exit 1
}

if grep -q 'MANJARO' /proc/version; then
    DISTRO="Manjaro"
    manjaro
elif grep -q 'artixlinux' /proc/version; then
    DISTRO="Artix"
    MIRRORURL="https://gitea.artixlinux.org/packagesA/artix-mirrorlist/raw/branch/master/trunk/mirrorlist"
    regular
    DISTRO="Artix (Arch mirrors)"
    MIRRORURL="https://archlinux.org/mirrorlist/all/"
    DEST="${DEST:-/etc/pacman.d/mirrorlist}-arch"
    regular
elif grep -q 'archlinux' /proc/version; then
    DISTRO="Arch"
    MIRRORURL="https://archlinux.org/mirrorlist/all/"
    regular
else
    echo "Your distro seems to not be supported"
    exit 1
fi

printf "$praefix Update Pacman database and packages $suffix"
sudo pacman -Syyu
