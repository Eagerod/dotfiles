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
echo "*.rsync_pass" >> ".rsync_exclude"
echo ".rsync_exclude" >> ".rsync_exclude"

# Sync Mac EVE to NAS
# do_backup "/Applications/EVE Online.app" "/backups/"

# Sync Steam Libraries to NAS
clear; echo "Syncing Steam library"
do_backup "/Users/Aleem/Library/Application Support/Steam/SteamApps/" "/backups/Mac SteamApps"

# Sync Photo Libraries to NAS
clear; echo "Syncing photo library from both directories"
do_backup "/Users/Aleem/Pictures/iPhoto Games Screenshots Library.photolibrary" "/backups/Photos/"
do_backup "/Users/Aleem/Pictures/iPhoto Library" "/backups/Photos/"

# Sync iPhone backups
clear; echo "Syncing iPhone backups"
do_backup "/Users/Aleem/Library/Application Support/MobileSync/Backup/" "/backups/iPhone Backups"

# Sync Home Directory Contents to NAS
clear; echo "Syncing ~ directories"
do_backup "/Users/Aleem/Documents" "/backups/"
do_backup "/Users/Aleem/Desktop/" "/backups/MacDesktop"
do_backup "/Users/Aleem/Dropbox" "/backups/"

# Sync up old Xcode Archives so that they can be cleared out from this system.
clear; echo "Syncing old Xcode Archives"
do_backup "/Users/Aleem/Library/Developer/Xcode/Archives" "/backups/XcodeArchives"

# If the external hard drive is plugged in, sync a bunch of shit from there.
if [ -d /Volumes/Games ]; then
	
	do_backup "/Volumes/Games/EVE" "/backups/"
	# Don't sync Guild Wars because the asshole developers wrapped up like 16 gigs into a single file. 
	# do_backup "/Volumes/Games/Guild Wars 2" "/backups/"
	# do_backup "/Volumes/Games/Program Files \(x86\)/Steam" "/backups/"

fi

rm ".rsync_exclude"
unset RSYNC_PASSWORD
