#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
	sh brew/brew.sh

	sh defaults/dock.sh
	sh defaults/defaults.sh

	duti file-associations/duti
else
    sh apt/apt.sh
    sh file-associations/gnome.sh
fi

bash bash/bash.sh
bash git/git.sh
bash vim/vim.sh

bash sublime/sublime.sh

if [ "$(stat -c "%U" /usr/local/bin)" != "$(whoami)" ]; then
    echo "/usr/local/bin not writeable, please provide permissions:"
    sudo chown $(whoami) /usr/local/bin
fi

bash bin/bin.sh
