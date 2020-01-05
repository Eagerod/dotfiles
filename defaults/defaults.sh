# No iCloud documents
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# No .DS_Store files on network shares
# https://support.apple.com/en-us/HT1629 (Pre 10.13.x?)
# defaults write com.apple.desktopservices DSDontWriteNetworkStores true
# https://support.apple.com/en-us/HT208209
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# Trackpad behavior
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable tabby spacey keyboard stuff
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Trackpad tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.6875

# Dock on left
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock tilesize -float 45
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -float 40

# Wait 1 minute before locking when screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -float 60
defaults -currentHost write com.apple.screensaver idleTime -int 60

# Zooming with control + scroll settings
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess closeViewSmoothImages -bool true

defaults write com.apple.airplay showInMenuBarIfPresent -bool true

# Menu Bar setup
defaults write com.apple.systemuiserver menuExtras -array
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Displays.menu"
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/AirPort.menu"

# Live in the matrix
defaults write com.apple.Terminal 'Startup Window Settings' -string Homebrew
defaults write com.apple.Terminal 'Default Window Settings' -string Homebrew

# Xcode settings
defaults write com.apple.dt.Xcode DVTTextShowLineNumbers -bool true
defaults write com.apple.dt.Xcode DVTTextPageGuideLocation -int 120
defaults write com.apple.dt.Xcode DVTTextShowPageGuide -bool true
defaults write com.apple.dt.Xcode DVTTextShowFoldingSidebar -bool true

# Flux
defaults write org.herf.Flux locationTextField -string '43.000,-81.000'
defaults write org.herf.Flux location -string '43.000,-81.000'
defaults write org.herf.Flux sleepLate -integer 1
defaults write org.herf.Flux "disable-org.videolan.vlc" -bool true

# Fix up Spotify's backgrounded skipping issue.
defaults write com.spotify.client NSAppSleepDisabled -bool YES

# Nested things that are tough to get with `defaults`
/usr/libexec/PlistBuddy -c "set DesktopViewSettings:IconViewSettings:iconSize 84" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set DesktopViewSettings:IconViewSettings:gridSpacing 72" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set DesktopViewSettings:IconViewSettings:arrangeBy dateModified" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set DesktopViewSettings:IconViewSettings:textSize 11" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "set DesktopViewSettings:IconViewSettings:showItemInfo YES" ~/Library/Preferences/com.apple.finder.plist

# Apparently the wallpaper information is stored in an SQLite DB, so use an Apple Script to set up wallpapers.
if [ -d "$HOME/Pictures/Wallpapers" ]; then
    osascript -e '
        tell application "System Events"
            set desktopCount to count of desktops
            repeat with desktopNumber from 1 to desktopCount
                tell desktop desktopNumber
                    set pictures folder to "'"$HOME/Pictures/Wallpapers"'"
                    set change interval to 300
                    set picture rotation to 1
                end tell
            end repeat
        end tell'
fi

echo "Modifying SystemConfiguration..."
sudo /usr/libexec/PlistBuddy -c "set Custom\ Profile:AC\ Power:Display\ Sleep\ Timer 1" /Library/Preferences/SystemConfiguration/com.apple.PowerManagement.plist
sudo /usr/libexec/PlistBuddy -c "set Custom\ Profile:Battery\ Power:Display\ Sleep\ Timer 1" /Library/Preferences/SystemConfiguration/com.apple.PowerManagement.plist
sudo -k # No side effects?

killall Dock
killall Xcode
killall SystemUIServer

echo "Some settings have been updated. But you'll have to log out and back in again for some settings to apply."
