#!/bin/sh

if ! type brew > /dev/null 2> /dev/null; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

brew install \
    docker \
    docker-compose \
    docker-machine \
    duti \
    git \
    neofetch

brew cask install sublime-text
brew cask install google-chrome
brew cask install virtualbox
brew cask install slack
brew cask install spotify
brew cask install steam
brew cask install vlc
brew cask install transmission
brew cask install flux
brew cask install istat-menus
brew cask install alfred

# For anything that was already installed.
brew upgrade
