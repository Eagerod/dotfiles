#!/usr/bin/env sh
#
#
SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
DOTFILES_DIR="$(cd "$(dirname $SCRIPT_DIR)" && pwd)"

. "$DOTFILES_DIR/utils.sh"

if [ "$(uname)" = "Linux" ]; then
	mkdir -p "$HOME/.config"
	create_symlink_and_backup "$DOTFILES_DIR/file-associations/mimeapps.list" "$HOME/.config/mimeapps.list"
elif [ "$(uname)" = "Darwin" ]; then
	duti "$SCRIPT_DIR/duti"
fi
