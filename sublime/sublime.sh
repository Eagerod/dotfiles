SUBLIME_DIR=$(find ~/Library/Application\ Support -type d -maxdepth 1 -iname "Sublime Text*" -print)

REL=`dirname $0`

curl "https://packagecontrol.io/Package%20Control.sublime-package" > "$SUBLIME_DIR/Installed Packages/Package Control.sublime-package"
cp "$REL/Preferences.sublime-settings" "$SUBLIME_DIR/Packages/User/"
cp "$REL/Package Control.sublime-settings" "$SUBLIME_DIR/Packages/User/"
