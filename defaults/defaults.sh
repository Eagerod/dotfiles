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
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -float 60
defaults -currentHost write com.apple.screensaver idleTime -int 60

# Zooming with control + scroll settings
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess closeViewSmoothImages -bool true

defaults write com.apple.airplay showInMenuBarIfPresent -bool true

# Live in the matrix
defaults write com.apple.Terminal 'Startup Window Settings' -string Homebrew
defaults write com.apple.Terminal 'Default Window Settings' -string Homebrew

# Xcode settings
defaults write com.apple.dt.Xcode DVTTextShowLineNumbers -bool true
defaults write com.apple.dt.Xcode DVTTextPageGuideLocation -int 120
defaults write com.apple.dt.Xcode DVTTextShowPageGuide -bool true

# Flux
defaults write org.herf.Flux locationTextField -string '43.000,-81.000'
defaults write org.herf.Flux location -string '43.000,-81.000'
defaults write org.herf.Flux sleepLate -integer 1

# Nested things that are tough to get with `defaults`
/usr/libexec/PlistBuddy -c "set DesktopViewSettings:IconViewSettings:iconSize 128" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set DesktopViewSettings:IconViewSettings:gridSpacing 72" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set DesktopViewSettings:IconViewSettings:arrangeBy dateModified" ~/Library/Preferences/com.apple.finder.plist

killall Dock
killall Xcode

echo "Some settings have been updated. But you'll have to log out and back in again for some settings to apply."
