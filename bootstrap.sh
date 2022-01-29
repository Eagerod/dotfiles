#!/usr/bin/env bash
#
# Get this machine up to snuff
set -eufxo pipefail

EXIT_CODE_INCORRECT_PERMISSIONS=1

PROJECTS_DIR="$HOME/Documents/personal/projects"
DOTFILES_DIR="$PROJECTS_DIR/dotfiles"

FALLBACK_TARGET=master
if [ $# -gt 0 ]; then
    FALLBACK_TARGET="$1"
fi

UNAME="$(uname)"
HTTPS_GIT_REMOTE="https://github.com/Eagerod/dotfiles"
FALLBACK_URL="$HTTPS_GIT_REMOTE/archive/$FALLBACK_TARGET.zip"

do_dotfiles_install()
{
    echo >&2 "Setting up a $UNAME machine..."

    if [ "$UNAME" = "Darwin" ]; then
        sh "$DOTFILES_DIR/brew/brew.sh"

        sh "$DOTFILES_DIR/defaults/dock.sh"
        sh "$DOTFILES_DIR/defaults/defaults.sh"
    else
        sh "$DOTFILES_DIR/apt/apt.sh"
    fi

    sh "$DOTFILES_DIR/file-associations/file-associations.sh"
    bash "$DOTFILES_DIR/bash/bash.sh"
    bash "$DOTFILES_DIR/git/git.sh"
    sh "$DOTFILES_DIR/vim/vim.sh"

    if [ ! -d /usr/local/bin ]; then
        sudo mkdir /usr/local/bin
    fi

    # Needs sudo to symlink everything under /usr/local/bin
    sudo sh "$DOTFILES_DIR/bin/bin.sh"
}

echo >&2 "This script symlinks dotfiles to the location its git repository."

if [ $(id -u) -eq 0 ]; then
    echo >&2 "Cannot bootstrap as root."
    echo >&2 "Run base script as unelevated user, and elevation will be requested as needed."
    exit $EXIT_CODE_INCORRECT_PERMISSIONS
fi

if [ ! -d "$PROJECTS_DIR" ]; then
    echo >&2 "Projects directory doesn't exist."
    echo >&2 "Creating projects directory..."
    mkdir -p "$PROJECTS_DIR"
fi

if [ ! -d "$DOTFILES_DIR/.git" ]; then
    temp_dir=$(mktemp -d)

    if [ ! -d "$DOTFILES_DIR" ]; then
        echo >&2 "No dotfiles directory contents found."
        echo >&2 "Downloading GitHub archive to the correct directory..."

        if type curl > /dev/null; then
            curl -fsSL "$FALLBACK_URL" -o "$temp_dir/dotfiles.zip"
        elif type wget > /dev/null; then
            wget "$FALLBACK_URL" -O "$temp_dir/dotfiles.zip"
        fi

        cd "$temp_dir"
        unzip -q dotfiles.zip
        rm -rf dotfiles.zip
        mv "dotfiles-$FALLBACK_TARGET" "$DOTFILES_DIR"
    else
        echo >&2 "Dotfiles directory has contents, but is not a Git repository; running with the existing contents."
    fi

    do_dotfiles_install

    echo >&2 "Dotfiles installation complete."
    echo >&2 "Upgrading existing directory to git repo."

    git clone "$HTTPS_GIT_REMOTE" "$temp_dir/dotfiles"
    mv "$temp_dir/dotfiles/.git" "$DOTFILES_DIR/.git"

    rm -rf "$temp_dir"
else
    do_dotfiles_install
fi
