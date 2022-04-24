#!/usr/bin/env bash


function check_correct() {
    declare -A question_options=(
        [question]="$1"
        [options]="$2"
        [correct]="$3"
    )
    local answer=$(echo "${question_options[options]}" | dmenu -i -l 12 -p "${question_options[question]}")
    if [[ "$answer" == "${question_options[correct]}" ]]; then
        local answer=$(printf "Yes\nNo" | dmenu -i -l 2 -p "Correct! Do you want to try again?")
        if [[ "$answer" == "Yes" ]]; then
            $4
        else
            main_menu
        fi
    else
        local answer=$(printf "Yes\nNo" | dmenu -i -l 2 -p "Incorrect! Do you want to try again?")
        if [[ "$answer" == "Yes" ]]; then
            check_correct "${question_options[question]}" "${question_options[options]}" "${question_options[correct]}" "$4"
        else
            main_menu
        fi
    fi
}


function random_easy_question() {
    local random_letter=$(shuf -n 1 -e "${!morse_code[@]}")
    local random_letter_morse_code=${morse_code[$random_letter]}
    local other_options=$(shuf -n 7 -e "${!morse_code[@]}" | xargs -I {} printf "%s%s\n" {} "${morse_code[$(echo {})]}" | grep -v $random_letter)
    local other_options=$(echo "$other_options" | sed 's/ /\n/g')
    local options=""
    for option in $other_options; do
        options="$options ${morse_code[$option]}"
    done
    options="$options $random_letter_morse_code"
    options=$(random "$options" " ")
    local prefix=""
    if [[ $random_letter =~ [0-9] ]]; then
        prefix="number"
    elif [[ $random_letter =~ [a-zA-Z] ]]; then
        prefix="letter"
    else
        prefix="pontuation"
    fi
    declare -A question_options=(
        [question]="What is the $prefix $random_letter in morse code?"
        [options]="$(echo $options | sed 's/ /\n/g')"
        [correct]="${morse_code[$random_letter]}"
    )
    check_correct "${question_options[question]}" "${question_options[options]}" "${question_options[correct]}" "random_easy_question"
}

function random_medium_question() {
    local random_letter=$(shuf -n 1 -e "${!morse_code[@]}")
    local random_letter_morse_code=${morse_code[$random_letter]}
    local other_options=$(shuf -n 7 -e "${!morse_code[@]}" | xargs -I {} printf "%s%s\n" {} "${morse_code[$(echo {})]}" | grep -v $random_letter)
    local other_options=$(echo "$other_options" | sed 's/ /\n/g')
    local options="$other_options $random_letter"
    options=$(random "$options" " ")

    declare -A question_options=(
        [question]="What is the $random_letter_morse_code in normal text?"
        [options]="$(echo $options | sed 's/ /\n/g')"
        [correct]="$random_letter"
    )
    check_correct "${question_options[question]}" "${question_options[options]}" "${question_options[correct]}" "random_medium_question"
}



function entire_words_to_morses() {
    local word_to_be_converted=$1
    local word_to_be_converted_morse_code=""
    for letter in $(echo $word_to_be_converted | sed 's/\(.\)/\1\n/g'); do
        word_to_be_converted_morse_code="$word_to_be_converted_morse_code ${morse_code[$letter]}"
    done
    echo $word_to_be_converted_morse_code
}

function morse_to_entire_words() {
    local morse_to_be_converted=$1
    local morse_to_be_converted_word=""
    for morse_code in $(echo $morse_to_be_converted | sed 's/ /\n/g'); do
        echo $morse_code
        for letter in "${!morse_code[@]}"; do
            if [[ "${morse_code[$letter]}" == "$morse_code" ]]; then
                letter=$(echo $letter | sed 's/0//g')
                morse_to_be_converted_word="$morse_to_be_converted_word$letter"
            fi
        done
    done
    echo $morse_to_be_converted_word
}


function random_hard_question() {
    local random_word=$(shuf -n 1 -e "${words[@]}")
    local random_word_morse_code=""
    for letter in $(echo $random_word | sed 's/\(.\)/\1\n/g'); do
        random_word_morse_code="$random_word_morse_code ${morse_code[$letter]}"
    done
    local morse_letters=()
    for letter in $(echo $random_word | sed -e 's/\(.\)/\1\n/g'); do
        echo $letter
        morse_letters+=("${morse_code[$letter]}")
    done
    local word_to_be_looped=$(echo $random_word | sed -e 's/\(.\)/\1\n/g')
    local index=0
    local formed_word=""
    while true; do
        local question="Spell the \"$random_word\" in morse code"
        got_morse=$(printf '%s\n' "${morse_code[@]}" | dmenu -i -l 12 -p "$question" )
        got_morse=$(echo $got_morse | sed 's/ //g')
        if [[ -z "$formed_word" ]]; then
            formed_word="$got_morse"
        else
            formed_word="$formed_word $got_morse"
        fi
        local option=$(printf 'Continue Spelling\nDone Spelling\nRestart\nQuit' | dmenu -i -l 12 -p "The word you have spelled is: \"$formed_word\"")
        if [[ "$option" == "Quit" || "$option" == "" ]]; then
            main_menu
        elif [[ "$option" == "Done Spelling" ]]; then
            formed_word=$(morse_to_entire_words "$formed_word")
            formed_word=$(echo $formed_word | awk 'NF{print $NF}')
            if [[ "$formed_word" == "$random_word" ]]; then
                local answer=$(printf "Yes\nNo" | dmenu -i -l 2 -p "Correct! Do you want to do it again?")
                if [[ "$answer" = "Yes" ]]; then
                    random_hard_question
                else
                    main_menu
                fi
            else
                local answer=$(printf "Yes\nNo" | dmenu -i -l 2 -p "Incorrect! Do you want to try again?")
                if [[ "$answer" == "Yes" ]]; then
                    random_hard_question
                else
                    main_menu
                fi
            fi
            break
        elif [[ "$option" == "Restart" ]]; then
            formed_word=""
            index=0
        fi
    done
}
