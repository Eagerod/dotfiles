#!/usr/bin/env bash

if [[ "$(uname)" == "Darwin" ]];
then
	sh brew/brew.sh

	sh defaults/dock.sh
	sh defaults/defaults.sh

	duti duti/duti # Lol
fi

bash bash/bash_profile.sh

cp git/gitconfig ~/.gitconfig
cp git/gitignore ~/.gitignore

bash sublime/sublime.sh

if [[ "$(stat -c "%U" /usr/local/bin)" != "$(whoami)" ]];
then
    echo "/usr/local/bin not writeable, please provide permissions:"
    sudo chown $(whoami) /usr/local/bin
fi

cp bin/* /usr/local/bin/
