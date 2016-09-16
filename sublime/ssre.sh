#!/usr/bin/env sh
#
# Super Simple Regular Expression Expander.
#
# Takes a very limited subset of regular expressions and expands out possible choices.
# Will (obviously) never work with regular expressions containing non-finitely repeating characters.
# Will probably not support very mechanisms that exist in regular expressions.
#
# Mechanisms that can probably not be supported:
# - Non-Finite repeating sequences - *, +
#
# Currently supported mechanisms:
# - Character Sets
#
# Things to support when the need arises:
# - Optional sequences - ?
# - Finite repeating sequences - {n,m}
# - Ors - |

append_word_to_all() {
    if [ $# -eq 1 ]
    then   
        echo "$1" 
    else
        local word=$1
        for i in $(seq 2 $#); 
        do     
           echo "${!i}$word" 
        done
    fi
}

expand_regular_expression() {
    local regular_expression="$1"
    local all_wordset=()
    local current_duplication_wordset=()
    local duplicating=false
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
            all_wordset+=($(append_word_to_all $character ${current_duplication_wordset[@]}))
        elif [ $duplicating = false ]
        then
            all_wordset=($(append_word_to_all $character ${all_wordset[@]}))
        fi
    done
    for word in ${all_wordset[@]}
    do
        echo $word
    done
}

while read regular_expression
do
    expand_regular_expression "$regular_expression"
done
