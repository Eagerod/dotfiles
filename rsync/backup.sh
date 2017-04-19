#!/bin/sh

if ! ping -c 1 "$1" > /dev/null; then
    echo "Usage: backup.sh <server ip> [RSYNC OPTIONS]"
    exit 1
fi

# "Session" variables to clean up the script.
remote_host=$1
additional_parameters="${@:2}"

do_backup() {
    # Escape spaces
    local_path="$1"
    remote_path=$(echo $2 | sed 's/ /\\ /g')
    rsync -ahuDH --progress "$additional_parameters" --exclude-from="$HOME/.gitignore" "$local_path" "rsync@$remote_host:/share$remote_path"
}

# Sync Steam Libraries to NAS
echo "Syncing Steam library"
do_backup "$HOME/Library/Application Support/Steam/SteamApps/" "/backups/Mac SteamApps"

# Sync Photo Libraries to NAS
echo "Syncing photo library from both directories"
do_backup "$HOME/Pictures/iPhoto Library" "/backups/Photos/"

# Sync iPhone backups
echo "Syncing iPhone backups"
do_backup "$HOME/Library/Application Support/MobileSync/Backup/" "/backups/iPhone Backups"

# Sync Home Directory Contents to NAS
echo "Syncing ~ directories"
do_backup "$HOME/Documents" "/backups/"
do_backup "$HOME/Desktop/" "/backups/MacDesktop"
do_backup "$HOME/Dropbox" "/backups/"

# Sync up old Xcode Archives so that they can be cleared out from this system.
echo "Syncing old Xcode Archives"
do_backup "$HOME/Library/Developer/Xcode/Archives" "/backups/XcodeArchives"

