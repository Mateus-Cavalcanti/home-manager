#!/usr/bin/env bash

GAME_DIR="$HOME/.config/nixpkgs/bash/game"

source "$GAME_DIR/utilities.sh"
source "$GAME_DIR/morse/morse.sh"
source "$GAME_DIR/morse/levels.sh"


function morse_options() {
    dmenu_options "easy=random_easy_question medium=random_medium_question hard=random_hard_question exit=exit"
}

function main_menu(){
    dmenu_options "morse=morse_options exit=exit" "Select a game option"
}

main_menu
