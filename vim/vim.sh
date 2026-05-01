#!/usr/bin/env sh
set -euf

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$(dirname "$SCRIPT_DIR")" && pwd)"
DEST_DIR="$HOME"
PLUGIN_DIR="$HOME/.vim/pack/plugins/start"

. "$DOTFILES_DIR/utils.sh"

create_symlink_and_backup "$SCRIPT_DIR/vimrc" "$DEST_DIR/.vimrc"

install_plugin() {
    repo="$1"
    name="$(basename "$repo")"

    if [ ! -d "$PLUGIN_DIR/$name" ]; then
        git clone "$repo" "$PLUGIN_DIR/$name"
    fi
}

install_plugin 'https://github.com/junegunn/fzf.git'
if ! type fzf; then
	$PLUGIN_DIR/fzf.git/install
	sudo ln -s "$PLUGIN_DIR/fzf.git/bin/fzf" "/usr/local/bin/fzf"
fi

install_plugin 'https://github.com/junegunn/fzf.vim.git'
