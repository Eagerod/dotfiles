#!/bin/sh

if ! type brew > /dev/null 2> /dev/null; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew update

brew install \
    docker \
    docker-compose \
    docker-machine \
    duti \
    git \
    neofetch

brew cask install \
    alfred \
    bitwarden \
    google-chrome \
    istat-menus \
    slack \
    spotify \
    steam \
    virtualbox \
    visual-studio-code \
    vlc

# For anything that was already installed.
brew upgrade
