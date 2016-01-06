# No iCloud documents
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Proper scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable tabby spacey keyboard stuff
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Trackpad tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.6875

# Dock on left
defaults write com.apple.dock orientation -string left

# Wait 1 minute before locking when screensaver
defaults write com.apple.screensaver askForPasswordDelay -float 60

# Zooming with control + scroll settings
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess closeViewSmoothImages -bool true

killall Dock

echo "Some settings have been updated. But you'll have to log out and back in again for some settings to apply."
