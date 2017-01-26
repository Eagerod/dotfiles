#!/usr/bin/env bash

if [[ "$(uname)" == "Darwin" ]];
then
	SUBLIME_DIR=$(find ~/Library/Application\ Support -maxdepth 1 -type d -iname "Sublime Text*" -print)
else
	SUBLIME_DIR=$(find ~/.config -maxdepth 1 -type d -iname "sublime-text*" -print)
fi

REL=`dirname $0`

curl "https://packagecontrol.io/Package%20Control.sublime-package" > "$SUBLIME_DIR/Installed Packages/Package Control.sublime-package"
cp "$REL/Package Control.sublime-settings" "$SUBLIME_DIR/Packages/User/"

# Build up the ignore_words set.
jsony=$(cat "$REL/ignored_words.txt" | bash "$REL/ssre.sh" | awk '{ print "\""$1"\"," }')
jsony=$(echo $jsony | sed 's/ //g')

# Ditch the trailing comma
if [ ! -z "$jsony" ]
then
    jsony=${jsony:0:${#jsony}-1}
fi

cp "$REL/Preferences.sublime-settings" "$SUBLIME_DIR/Packages/User/"


if [[ "$(uname)" == "Darwin" ]];
then
    sed -i '' -e 's/"ignored_words": \[.*]/"ignored_words": \['$jsony']/g' "$SUBLIME_DIR/Packages/User/Preferences.sublime-settings"
else
    sed -i'' -e 's/"ignored_words": \[.*]/"ignored_words": \['$jsony']/g' "$SUBLIME_DIR/Packages/User/Preferences.sublime-settings"
fi
