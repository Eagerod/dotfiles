brew update

brew install caskroom/cask/brew-cask
brew install git
brew install heroku-toolbelt
brew install nodejs
brew install mongodb
brew install duti
brew install --with-rlwrap repl
# brew install boot2docker # Only if doing docker stuff.

brew cask install ngrok
brew cask install sublime-text
brew cask install dropbox
brew cask install google-chrome
brew cask install firefox
brew cask install virtualbox
brew cask install skype
brew cask install slack
brew cask install spotify
brew cask install steam
brew cask install vlc
brew cask install mactex
brew cask install robomongo
brew cask install transmission
brew cask install flux
brew cask install istat-menus

# For anything that was already installed.
brew upgrade --all
