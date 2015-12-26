# No iCloud documents
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Proper scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable tabby spacey keyboard stuff
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Some settings have been updated. But you'll have to log out and back in again for some settings to apply."
