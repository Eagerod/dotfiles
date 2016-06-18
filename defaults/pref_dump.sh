#!/usr/bin/env sh
#
# Script I use to dump out all of my preferences into a single place. Best used with some kind of diffing software,
# especially if comparing preferences over time or on different machines.
#

# Search for excludes file path, or output path
exclude_entries=""
output_path=$(pwd)
while [ $# -gt 0 ]; do
    case $1 in
        -o)
            shift
            output_path=$(cd $1; pwd)
            shift
            ;;
        -e) 
            shift
            exclude_entries=$(cat $1)
            shift
            ;;
    esac
done

# Changes paths to certain things.
my_host=`defaults read com.apple.InputMethodKit.UserDictionary LocalPeerIdentityCurrent | sed s/.*\~//g`

mkdir -p "$output_path/ByHost"

# Find all plists in the Preferences directory, and loop over them.
find ~/Library/Preferences -iname "*.plist" | while read pref;
do
    pref_base=$(basename $pref)
    do_host="n"
    if [[ $pref_base = *$my_host.plist ]]; then
        pref_base=${pref_base%.$my_host.plist}
        do_host="y"
    fi

    # Use some subshell hackery to skip certain files if the subshell terminates with a nonzero status code.
    skip="n"
    echo "$exclude_entries" | while read skipper; do
        if [[ $do_host = "y" ]]; then
            if [[ ByHost/${pref_base%.plist} = $skipper ]]; then
                exit -1
            fi
        elif [[ ${pref_base%.plist} = $skipper ]]; then
            exit -1
        fi
    done || skip="y"

    if [ $skip = "y" ]; then
        continue
    fi

    if [ $do_host = "y" ]; then
        defaults -currentHost read "$pref" > "$output_path/ByHost/$pref_base" 2> /dev/null
    else 
        defaults read "$pref" > "$output_path/$pref_base" 2> /dev/null
    fi
done
