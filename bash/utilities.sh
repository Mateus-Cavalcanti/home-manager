#!/usr/bin/env bash
levelselect="$HOME/.config/nixpkgs/bash/game/morse/levelselect.sh"
packages_dmenu="$HOME/.config/nixpkgs/bash/packages_dmenu.sh"

selected=$(printf "Game\nPackages" | dmenu -i -l 2 -p "Utilities:")

if [ "$selected" = "Game" ]; then
    source $levelselect
elif [ "$selected" = "Packages" ]; then
    source $packages_dmenu
fi
