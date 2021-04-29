#!/usr/bin/env sh
set -euf

SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
DOTFILES_DIR="$(cd "$(dirname $SCRIPT_DIR)" && pwd)"
DEST_DIR=$HOME

. "$DOTFILES_DIR/utils.sh"

create_symlink_and_backup "$SCRIPT_DIR/vimrc" "$DEST_DIR/.vimrc"
