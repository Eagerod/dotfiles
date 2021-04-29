#!/usr/bin/env bash
#
set -euf

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$(dirname "$SCRIPT_DIR")" && pwd)"
DEST_DIR="$HOME"

. "$DOTFILES_DIR/utils.sh"

create_symlink_and_backup "$SCRIPT_DIR/gitconfig" "$DEST_DIR/.gitconfig"

# Could technically filter out the linux/mac/windows from this.
# Probably not worth the effort.
GITIGNORE_SOURCES=(
    "linux"
    "macos"
    "windows"

    "intellij"
    "git"
    "sublimetext"
    "vim"
    "vscode"
    "zsh"
)

curl -fsSL "https://www.toptal.com/developers/gitignore/api/$(echo "${GITIGNORE_SOURCES[*]}" | sed 's/ /,/g')" > "$DEST_DIR/.gitignore"
