#!/bin/sh

sh brew/brew.sh

sh defaults/dock.sh
sh defaults/defaults.sh

duti duti/duti # Lol

cp git/gitconfig ~/.gitconfig
cp git/gitignore ~/.gitignore

cp sublime/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/

cp bin/* /usr/local/bin/
