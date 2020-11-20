APP_INSTALLATION_DIRECTORIES=(
    '/Applications'
    '/System/Applications'
    '/usr/local/Caskroom'
)

clear_dock() {
    defaults write com.apple.dock persistent-apps -array
    defaults write com.apple.dock persistent-others -array
}

add_app_to_dock() {
    filename=$1
    filepath="file://$(find ${APP_INSTALLATION_DIRECTORIES[@]} -maxdepth 3 -iname "$filename")"
    url_string="<key>_CFURLString</key><string>$filepath</string>"
    url_string_type="<key>_CFURLStringType</key><integer>15</integer>"
    file_data="<key>file-data</key><dict>$url_string$url_string_type</dict>"
    tile_data="<key>tile-data</key><dict>$file_data</dict>"
    tile_type="<key>tile-type</key><string>file-tile</string>"
    defaults write com.apple.dock persistent-apps -array-add "<dict>$tile_data$tile_type</dict>"
}

add_other_to_dock() {
    directory=$1
    url_string="<key>_CFURLString</key><string>file://$directory</string>"
    url_string_type="<key>_CFURLStringType</key><integer>15</integer>"
    file_data="<key>file-data</key><dict>$url_string$url_string_type</dict>"
    displayas="<key>displayas</key><integer>1</integer>"
    arrangement="<key>arrangement</key><integer>3</integer>"
    tile_data="<key>tile-data</key><dict>$file_data$displayas$arrangement</dict>"
    tile_type="<key>tile-type</key><string>directory-tile</string>"
    defaults write com.apple.dock persistent-others -array-add "<dict>$tile_data$tile_type</dict>"
}

add_app_spacer_to_dock() {
    defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
}

clear_dock

# Always on apps.
add_app_to_dock "Spotify.app"
add_app_to_dock "Terminal.app"
add_app_to_dock "Visual Studio Code*.app"

add_app_spacer_to_dock

# Usually on apps.
add_app_to_dock "Google Chrome.app"
add_app_to_dock "Slack.app"

add_app_spacer_to_dock

# All transient apps go below this spacer.

add_other_to_dock "$HOME/Documents/"
add_other_to_dock "$HOME/Downloads/"

killall Dock
