#!/usr/bin/env bash

CHOOSEN=$(printf "python3.10\npython3.9\nnodejs\ngeneric" | dmenu -l 12 -i -p "Choose a language:")

function ocurrences {
    grep -o " " <<< "$1" | wc -l
}

AWK_GET_LAST_WORD="{print \$NF}"
AWK_GET_FIRST_WORD="{print \$1}"
ADD=$(printf "Copy to clipboard\nAdd to packages" | dmenu -l 12 -i -p "What do you want to do?")
if [ "$ADD" = "Copy to clipboard" ]; then
    ADD=false
else 
    if [ "$ADD" = "Add to packages" ]; then
        ADD=true
    else
        exit
    fi
fi
USE_CACHED_PACKAGES=$(printf "Use cached packages\nUse latest packages" | dmenu -l 12 -i -p "What do you want to do?")
if [ "$USE_CACHED_PACKAGES" = "Use cached packages" ]; then
    USE_CACHED_PACKAGES=true
else 
    if [ "$USE_CACHED_PACKAGES" = "Use latest packages" ]; then
        USE_CACHED_PACKAGES=false
    else
        exit
    fi
fi

function add_to_pendents() {
    if [ "$USE_CACHED_PACKAGES" = true ]; then
        if [ ! -f ~/.cache/pkgs/pendents/$1 ]; then
            notify-send "Cached file doesn't exist"
            exit
        fi
        PACKAGES=$(cat ~/.cache/pkgs/pendents/$1)
    else
        PACKAGES=$(nix-env -qaPA "$1")
    fi
    mkdir -p ~/.cache/pkgs/pendents
    echo "$PACKAGES" > ~/.cache/pkgs/pendents/$1

    PACKAGES=$(echo "$PACKAGES" | sed "s/$1.\(.*\)/\1/" | awk "$AWK_GET_FIRST_WORD" | dmenu -l 12 -i -p "Choose a package:")
    for PACKAGE in $PACKAGES; do
        PACKAGESNEW="$PACKAGESNEW $2$PACKAGE"
    done
    for PACKAGE in $PACKAGESNEW; do
        if [ "$ADD" = true ]; then
            if ! grep -q "$PACKAGE" $HOME/.config/nixpkgs/pkgs/user-pendents.txt; then
                if ! grep -q "$PACKAGE" $HOME/.config/nixpkgs/pkgs/user-installed.txt; then
                    echo "$PACKAGE" >> $HOME/.config/nixpkgs/pkgs/user-pendents.txt
                    notify-send "Package added to pendents" "$PACKAGE"
                else
                    notify-send "Package already installed" "$PACKAGE"
                fi
            else
                notify-send "Package already in pendents" "$PACKAGE"
            fi
        else
            echo "$PACKAGE" | xclip -selection clipboard
            notify-send "Package copied to clipboard" "$PACKAGE"
        fi
    done
}


if [ "$CHOOSEN" = "python3.10" ]; then
    add_to_pendents "nixos.python310Packages" "python310Packages."
elif [ "$CHOOSEN" = "python3.9" ]; then
    add_to_pendents "nixos.python39Packages" "python39Packages."
elif [ "$CHOOSEN" = "nodejs" ]; then
    add_to_pendents "nixos.nodePackages" "nodePackages."
elif [ "$CHOOSEN" = "generic" ]; then
    add_to_pendents "nixos" ""
fi
