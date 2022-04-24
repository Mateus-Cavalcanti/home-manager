function dmenu_options() {
    declare -A options
    for option in $1; do
        key=$(echo $option | cut -d= -f1)
        value=$(echo $option | cut -d= -f2)
        options[$key]=$value
    done
    local selected=$(echo "${!options[@]}" | sed 's/ /\n/g'| dmenu -l 5 -p "$2")
    ${options[$selected]} $selected
}


function random() {
    local mainvar=$1
    local sep=$2
    local main=$(echo "$mainvar" | awk -v sep="$sep" '{for(i=1;i<=NF;i++)a[i]=$i;for(i=NF;i>=1;i--)print a[i];}' | shuf | awk -v sep="$sep" '{for(i=1;i<=NF;i++)printf "%s%s",$i,sep;print ""}')
    echo $main
}


declare -A alphabet=(
    [1]="a"
    [2]="b"
    [3]="c"
    [4]="d"
    [5]="e"
    [6]="f"
    [7]="g"
    [8]="h"
    [9]="i"
    [10]="j"
    [11]="k"
    [12]="l"
    [13]="m"
    [14]="n"
    [15]="o"
    [16]="p"
    [17]="q"
    [18]="r"
    [19]="s"
    [20]="t"
    [21]="u"
    [22]="v"
    [23]="w"
    [24]="x"
    [25]="y"
    [26]="z"
)

words=("hello" "people" "how" "you" "doing" "what" "when" "while" "john" "who" "cares" "about" "that" "heck" "help" "face" "faces" "help" "verve"
    "bash" "javascript" "array" "awk" "newline" "sep" "function" "print" "for" "options" "dmenu" "lol" "utilities" "config" "nixpkgs" "home")

function awk_sep_to_newline() {
    echo "$1" | awk -v sep="$2" '{for(i=1;i<=NF;i++)a[i]=$i;for(i=NF;i>=1;i--)print a[i];}' | awk -v sep="$sep" '{for(i=1;i<=NF;i++)printf "%s%s",$i,sep;print ""}'
}
