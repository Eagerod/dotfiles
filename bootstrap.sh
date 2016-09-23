#!/bin/sh

sh brew/brew.sh

sh defaults/dock.sh
sh defaults/defaults.sh

duti duti/duti # Lol

sh bash/bash_profile.sh

cp git/gitconfig ~/.gitconfig
cp git/gitignore ~/.gitignore

sh sublime/sublime.sh

cp bin/* /usr/local/bin/
