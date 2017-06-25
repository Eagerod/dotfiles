#!/bin/sh

usage() {
    echo >&2 "Usage: backup.sh <remote_host> [RSYNC OPTIONS]"
}

if ! ping -c 1 "$1" > /dev/null; then
    echo >&2 "Must provide a valid host for rsync"
    usage
    exit 1
fi

# "Session" variables to clean up the script.
remote_host=$1
additional_parameters="${@:2}"

if [[ "$additional_parameters" == *"--delete"* ]]; then
    echo >&2 "Cannot use '--delete' as a global parameter"
    usage
    exit -1
fi

do_backup() {
    # Backup $1 to $2, using $3...$n as additional parameters to rsync on top of $additional_parameters
    # Escape spaces
    local_path="$1"
    remote_path=$(echo $2 | sed 's/ /\\ /g')
    even_more_parameters="${@:3}"
    all_parameters="$additional_parameters $even_more_parameters"
    rsync -ahuDH --progress $all_parameters --exclude-from="$HOME/.gitignore" "$local_path" "rsync@$remote_host:/share$remote_path"
}

# Sync Steam Libraries to NAS
echo "Syncing Steam library"
do_backup "$HOME/Library/Application Support/Steam/SteamApps/" "/backups/Mac SteamApps"

# Reloop over all games in the steamapps directory, and clean up any files that still exist in the remote that don't 
# exist here, in case games have removed assets, libraries, whatever.
find "$HOME/Library/Application Support/Steam/SteamApps/common" -type d -d 1 | while read line; do
    line=$(echo "$line" | sed "s|$HOME\/Library\/Application\ Support\/Steam\/SteamApps\/||")
    echo "Syncing $(echo $line | sed "s|common/||")"
    do_backup "$HOME/Library/Application Support/Steam/SteamApps/$line/" "/backups/Mac SteamApps/$line" --delete
done

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

echo "Syncing MongoDB databases"
do_backup "/usr/local/var/mongodb/" "/backups/mongodb"
