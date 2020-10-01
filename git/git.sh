#!/usr/bin/env sh

SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
DOTFILES_DIR="$(cd "$(dirname $SCRIPT_DIR)" && pwd)"
DEST_DIR=$HOME

. "$DOTFILES_DIR/utils.sh"

create_symlink_and_backup "$SCRIPT_DIR/gitconfig" "$DEST_DIR/.gitconfig"
create_symlink_and_backup "$SCRIPT_DIR/gitignore" "$DEST_DIR/.gitignore"
