SUBLIME_DIR=$(find ~/Library/Application\ Support -type d -maxdepth 1 -iname "Sublime Text*" -print)

REL=`dirname $0`

curl "https://packagecontrol.io/Package%20Control.sublime-package" > "$SUBLIME_DIR/Installed Packages/Package Control.sublime-package"
cp "$REL/Package Control.sublime-settings" "$SUBLIME_DIR/Packages/User/"

# Build up the ignore_words set.
jsony=$(cat "$REL/ignored_words.txt" | sh "$REL/ssre.sh" | awk '{ print "\""$1"\"," }')
jsony=$(echo $jsony | sed 's/ //g')

# Ditch the trailing comma
if [ ! -z "$jsony" ]
then
    jsony=${jsony:0:${#jsony}-1}
fi

sed -i '' -e 's/"ignore_words": \[.*]/"ignore_words": \['$jsony']/g' "$REL/Preferences.sublime-settings"

cp "$REL/Preferences.sublime-settings" "$SUBLIME_DIR/Packages/User/"

sed -i '' -e 's/"ignore_words": \[.*]/"ignore_words": \[]/g' "$REL/Preferences.sublime-settings"
