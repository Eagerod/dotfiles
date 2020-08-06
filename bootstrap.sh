#!/usr/bin/env bash
#
# Get this machine up to snuff
set -e

SCRIPT_DIR="$(cd $(dirname "$0") && pwd)"

UNAME="$(uname)"
FALLBACK_URL="https://github.com/Eagerod/dotfiles/archive/master.zip"

if [ ! -d .git ]; then
	echo >&2 "It seems like this is being run outside the repo."
	echo >&2 "Downloading master build from GitHub and rerunning..."

	temp_dir="$(mktemp -d)"
	pushd "$temp_dir"
	echo "Running in $temp_dir"

	# Depending on the platform, download using the program most likely to be
	#   installed.
	if [ "$UNAME" == "Darwin" ]; then
		curl -fsSL "$FALLBACK_URL" -o dotfiles.zip
	else
		wget "$FALLBACK_URL" -O dotfiles.zip
	fi

	unzip dotfiles.zip
	sh dotfiles-master/bootstrap.sh
	popd
	rm -rf "$temp_dir"

	exit
fi

echo >&2 "Setting up a $UNAME machine..."

if [ "$UNAME" == "Darwin" ]; then
	sh "$SCRIPT_DIR/brew/brew.sh"

	sh "$SCRIPT_DIR/defaults/dock.sh"
	sh "$SCRIPT_DIR/defaults/defaults.sh"

	duti "$SCRIPT_DIR/file-associations/duti"
else
    sh "$SCRIPT_DIR/apt/apt.sh"
    sh "$SCRIPT_DIR/file-associations/gnome.sh"
fi

bash "$SCRIPT_DIR/bash/bash.sh"
bash "$SCRIPT_DIR/git/git.sh"
bash "$SCRIPT_DIR/vim/vim.sh"

bash "$SCRIPT_DIR/sublime/sublime.sh"

if [ "$(stat -c "%U" /usr/local/bin)" != "$(whoami)" ]; then
    echo "/usr/local/bin not writeable, please provide permissions:"
    sudo chown $(whoami) /usr/local/bin
fi

bash "$SCRIPT_DIR/bin/bin.sh"
