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
# - Optional sequences - ?
#
# Things to support when the need arises:
# - Finite repeating sequences - {n,m}
# - Ors - |

STRING_REGEX="^([a-zA-Z]+)"
CHARACTER_SET_REGEX="^\[([a-zA-Z]+)\]"
OPTIONAL_REGEX="^\?"

# Recurse through, and consume left-most pieces of the regular expression, 
# passing the remainder, and a single prefixes into the next recursion.
expand_regular_expression() {
    local prefix=$1
    local expression=$2

    if [ -z "$expression" ]
    then
        echo "$prefix"
        return
    fi

    # Just more text to print out:
    if [[ "$expression" =~ $STRING_REGEX ]]
    then
        local characters="${BASH_REMATCH[1]}"
        local remaining_expression=${expression:${#BASH_REMATCH[0]}}

        if [[ "$remaining_expression" =~ $OPTIONAL_REGEX ]]
        then
            remaining_expression=${remaining_expression:1:$((${#remaining_expression}-1))}
            expand_regular_expression "$prefix" $remaining_expression
        fi

        expand_regular_expression "$prefix$characters" "$remaining_expression"
        return
    fi

    # If the expression is a character group:
    if [[ "$expression" =~ $CHARACTER_SET_REGEX ]]
    then
        local characters="${BASH_REMATCH[1]}"
        local remaining_expression=${expression:${#BASH_REMATCH[0]}}

        if [[ "$remaining_expression" =~ $OPTIONAL_REGEX ]]
        then
            remaining_expression=${remaining_expression:1:$((${#remaining_expression}-1))}
            expand_regular_expression "$prefix" $remaining_expression
        fi

        for i in $(seq 0 ${#characters[@]})
        do
            local character=${characters:$i:1}
            expand_regular_expression "$prefix$character" $remaining_expression
        done
        return
    fi
}

while read regular_expression
do
    expand_regular_expression "" "$regular_expression"
done
