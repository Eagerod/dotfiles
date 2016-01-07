clear_dock() {
    defaults write com.apple.dock persistent-apps -array
}

add_item_to_dock() {
    fileroot=$1
    filename=$2
    filepath="file://"`find $1 -maxdepth 2 -iname "$2"`
    url_string="<key>_CFURLString</key><string>$filepath</string>"
    url_string_type="<key>_CFURLStringType</key><integer>15</integer>"
    file_data="<key>file-data</key><dict>$url_string$url_string_type</dict>"
    tile_data="<key>tile-data</key><dict>$file_data</dict>"
    tile_type="<key>tile-type</key><string>file-tile</string>"
    defaults write com.apple.dock persistent-apps -array-add "<dict>$tile_data$tile_type</dict>"
}

add_spacer_to_dock() {
    defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
}

clear_dock

# Always on apps.
add_item_to_dock "/opt/homebrew-cask/Caskroom/spotify" "Spotify.app"
add_item_to_dock "/Applications" "Messages.app"
add_item_to_dock "/opt/homebrew-cask/Caskroom/sublime-text" "Sublime Text 2.app"
add_item_to_dock "/Applications" "Terminal.app"
if type charm > /dev/null 2> /dev/null; then
    add_item_to_dock "/opt/homebrew-cask/Caskroom/pycharm" "PyCharm.app"
fi

add_spacer_to_dock

# Usually on apps.
add_item_to_dock "/Applications" "Google Chrome.app"
add_item_to_dock "/opt/homebrew-cask/Caskroom/slack" "Slack.app"

add_spacer_to_dock

# All transient apps go below this spacer.

killall Dock