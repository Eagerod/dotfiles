#!/bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: backup.sh <server ip> <password>"
fi

# "Session" variables to clean up the script.
ip_address=$1
export RSYNC_PASSWORD=$2

do_backup() {
    rsync -ahuDH --progress --exclude-from=.rsync_exclude "$1" "rsync://rsync@$ip_address:$2"
}

echo "*.DS_Store" > ".rsync_exclude"
echo "*/.git/*" >> ".rsync_exclude"
echo ".rsync_exclude" >> ".rsync_exclude"

# Sync Steam Libraries to NAS
clear; echo "Syncing Steam library"
do_backup "$HOME/Library/Application Support/Steam/SteamApps/" "/backups/Mac SteamApps"

# Sync Photo Libraries to NAS
clear; echo "Syncing photo library from both directories"
do_backup "$HOME/Pictures/iPhoto Library" "/backups/Photos/"

# Sync iPhone backups
clear; echo "Syncing iPhone backups"
do_backup "$HOME/Library/Application Support/MobileSync/Backup/" "/backups/iPhone Backups"

# Sync Home Directory Contents to NAS
clear; echo "Syncing ~ directories"
do_backup "$HOME/Documents" "/backups/"
do_backup "$HOME/Desktop/" "/backups/MacDesktop"
do_backup "$HOME/Dropbox" "/backups/"

# Sync up old Xcode Archives so that they can be cleared out from this system.
clear; echo "Syncing old Xcode Archives"
do_backup "$HOME/Library/Developer/Xcode/Archives" "/backups/XcodeArchives"

rm ".rsync_exclude"
unset RSYNC_PASSWORD
