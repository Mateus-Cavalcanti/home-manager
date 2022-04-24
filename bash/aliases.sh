MAIN_DIRS=("$HOME/work")
IGNORE_DIRS=("^k" "^K")

for dir in "${MAIN_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "The directory $dir does not exist"
        exit 1
    fi
done

for dir in "${MAIN_DIRS[@]}"; do
    first_letter=$(echo "$dir" | sed -r 's/^.*\///' | sed -r 's/^(.)/\U\1/')
    first_letter=${first_letter:0:1}

    if [ -n "$(command -v "$first_letter")" ]; then
        echo "The command $first_letter is in the path"
        exit 1
    fi


    dirs=$(find "$dir" -type d)
    dirs=$(echo $dirs | replace "$dir" "")
    for ignored_dir in "${IGNORE_DIRS[@]}"; do
        dirs=$(echo $dirs | cut -c2- | tr ' ' '\n' | grep -v "$ignored_dir")
    done
    
    letters_array=()
    final_array=()
    finnal_words_array=()
    for dirloop in $dirs; do
        no=False
        letter_conjunt=""
        for letter in $(echo $dirloop | tr ' ' '\n' | grep -o .); do
            letter=$(echo $letter | tr 'A-Z' 'a-z')
            if [[ $letter =~ [a-z] ]]; then
                letter_conjunt="$letter_conjunt$letter"
                if [ "$no" = False ]; then
                    letters_array+=("$letter_conjunt")
                else
                    for i in "${!letters_array[@]}"; do
                        if [ "${letters_array[$i]}" = "$letter_conjunt" ]; then
                            final_array[$i]="${final_array[$i]} $dirloop"
                            final_words_array[$i]="${final_words_array[$i]}"

                            break
                        fi
                    done
                fi
            else
                if [ -z "$letter_conjunt" ]; then
                    letter_conjunt=""
                else
                    letter_conjunt="${letter_conjunt}E"
                    no=True

                fi
            fi
            echo "alias $first_letter$letter_conjunt='cd $dir/$dirloop'"
        done
    done
done


for i in "${!final_array[@]}"; do
    echo "alias $first_letter${letters_array[$i]}='cd ${final_array[$i]}'"
done
