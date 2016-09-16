#!/usr/bin/env sh
#
# Super Simple Regular Expression Expander.
#
# Takes a very limited subset of regular expressions and expands out possible choices.
# Will (obviously) never work with regular expressions containing non-finitely repeating characters.
# Will probably not support very mechanisms that exist in regular expressions.
#
# Currently supported mechanisms:
# - Character Sets

append_character_to_all() {
    if [ $# -eq 1 ]
    then   
        echo "$1" 
    else
        local character=$1
        for i in $(seq 2 $#); 
        do     
           echo "${!i}$character" 
        done
    fi
}

duplicating=false

while read regular_expression 
do
    all_wordset=()
    current_duplication_wordset=()
    for i in $(seq 0 $((${#regular_expression}-1))) 
    do
        character=${regular_expression:$i:1}
        if [ $character = "[" ]
        then
            # Duplicate entire word_builder for every character until "]"
            duplicating=true
            current_duplication_wordset=("${all_wordset[@]}")
            all_wordset=()
        elif [ $character = "]" ]
        then
            duplicating=false
            current_duplication_wordset=("${all_wordset[@]}")
        elif [ $duplicating = true ]
        then
            all_wordset+=($(append_character_to_all $character ${current_duplication_wordset[@]}))
        elif [ $duplicating = false ]
        then
            all_wordset=($(append_character_to_all $character ${all_wordset[@]}))
        fi
    done
    for word in ${all_wordset[@]}
    do
        echo $word
    done
done
