#!/usr/bin/env bash

DOTFILES_DIR=$(dirname $0)

if [[ "$(uname)" == "Darwin" ]];
then
	sh brew/brew.sh

	sh defaults/dock.sh
	sh defaults/defaults.sh

	duti file-associations/duti
else
    sh apt/apt.sh
    sh file-associations/gnome.sh
fi

bash bash/bash_profile.sh

bash git/git.sh

bash sublime/sublime.sh

if [[ "$(stat -c "%U" /usr/local/bin)" != "$(whoami)" ]];
then
    echo "/usr/local/bin not writeable, please provide permissions:"
    sudo chown $(whoami) /usr/local/bin
fi

find bin -mindepth 1 -maxdepth 1 -print | sed 's:^bin/::' | while read line; do
    ln -s $DOTFILES_DIR/bin/$line /usr/local/bin/$line 2> /dev/null
done
