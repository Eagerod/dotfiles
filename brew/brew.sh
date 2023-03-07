#!/bin/sh
set -euf

if ! type brew > /dev/null 2> /dev/null; then
    if ! bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; then
        echo >&2 "Homebrew requires the user session to be authenticated."
        echo >&2 "Possibly need to run a simple sudoed command before continuing."
        exit 1
    fi

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update

brew install \
    bitwarden \
    docker \
    docker-compose \
    docker-machine \
    duti \
    git \
    google-chrome \
    neofetch \
    raycast \
    slack \
    spotify \
    steam \
    visual-studio-code \
    vlc

# For anything that was already installed.
brew upgrade
