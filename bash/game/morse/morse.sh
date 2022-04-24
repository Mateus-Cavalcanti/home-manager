#!/usr/bin/env bash

declare -A morse_code=(
    [a]=".-"
    [b]="-..."
    [c]="-.-."
    [d]="-.."
    [e]="."
    [f]="..-."
    [g]="--."
    [h]="...."
    [i]=".."
    [j]=".---"
    [k]="-.-"
    [l]=".-.."
    [m]="--"
    [n]="-."
    [o]="---"
    [p]=".--."
    [q]="--.-"
    [r]=".-."
    [s]="..."
    [t]="-"
    [u]="..-"
    [v]="...-"
    [w]=".--"
    [x]="-..-"
    [y]="-.--"
    [z]="--.."
    [.]=".-.-.-"
    [,]="--..--"
    [ ]="/"
)

function letter_to_morse() {
    local letter=$1
    letter=${letter,,}
    if [[ ${morse_code[$letter]} ]]; then
        echo "${morse_code[$letter]}"
    else
        echo "Invalid letter"
    fi
}

function morse_to_letter() {
    local morse=$1
    for letter in "${!morse_code[@]}"; do
        if [[ ${morse_code[$letter]} == $morse ]]; then
            if [[ ! $letter =~ [0-9] ]]; then
                echo "$letter"
            fi
        fi
    done
}

