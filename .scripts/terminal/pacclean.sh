#! /bin/sh
# Dependencies: pacman paccache


echo
echo "### UPDATING MIRROR LIST (1/4) ###"
echo
if command -v pacman-mirrors > /dev/null; then
    sudo pacman-mirrors --geoip --api --protocol https
else
    echo "pacman-mirrors not available (Manjaro only)"
    echo "You might have to update them by yourself"
fi


command -v yay > /dev/null && PACMANAGER="yay" || PACMANAGER="sudo pacman"

echo
echo
echo "### UPDATING (2/4) ###"
echo
$PACMANAGER -Syyu


echo
echo
echo "### CLEANING UP ORPHANS (3/4) ###"
echo
if ! [ "$($PACMANAGER -Qdtq)" = "" ]; then
    echo "=> First run:"
    $PACMANAGER -Rn $($PACMANAGER -Qdtq) --noconfirm

    echo "=> Rerunning until all dependencies are clean"
    while ! [ "$($PACMANAGER -Qdtq)" = "" ]; do
	$PACMANAGER -Rn $($PACMANAGER -Qdtq) --noconfirm
    done
else
    echo "No orphans found"
fi

echo
echo
echo "### CLEANING UP THE CACHE (4/4) ###"
echo
echo "Cleaning cache older than three versions"
sudo paccache -rvk3
$PACMANAGER -Scc

echo
echo "DONE"
