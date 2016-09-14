SUBLIME_DIR=$(find ~/Library/Application\ Support -type d -maxdepth 1 -iname "Sublime Text*" -print)

REL=`dirname $0`

cp "$SUBLIME_DIR/Packages/User/Preferences.sublime-settings" "$REL/"
cp "$SUBLIME_DIR/Packages/User/Package Control.sublime-settings" "$REL/"
