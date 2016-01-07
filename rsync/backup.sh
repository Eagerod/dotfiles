#!/bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: backup.sh <server ip> <password>"
fi

# "Session" variables to clean up the script.
ip_address=$1
export RSYNC_PASSWORD=$2

dst_root="rsync://rsync@$ip_address"
rsync_params="-ahuDH --progress"

echo "*.DS_Store" > ".rsync_exclude"
echo "*/.git/*" >> ".rsync_exclude"
echo "*.rsync_pass" >> ".rsync_exclude"
echo ".rsync_exclude" >> ".rsync_exclude"
rsync_params="$rsync_params --exclude-from=.rsync_exclude"

# Sync Mac EVE to NAS
# rsync $rsync_params "/Applications/EVE Online.app" $dst_root:/backups/

# Sync Diablo 3 from the Windows Partition to NAS
# rsync $rsync_params "/Volumes/Windows HD/Blizzard" $dst_root:/backups/Blizzard

# Sync Steam Libraries to NAS
clear; echo "Syncing Steam library from both partitions"
rsync $rsync_params "/Users/Aleem/Library/Application Support/Steam/SteamApps/" $dst_root:/backups/Mac\ SteamApps
rsync $rsync_params "/Volumes/Windows HD/Program Files (x86)/Steam/steamapps/" $dst_root:/Games/Steam/steamapps/

# Sync Photo Libraries to NAS
clear; echo "Syncing photo library from both directories"
rsync $rsync_params "/Users/Aleem/Pictures/iPhoto Games Screenshots Library.photolibrary" $dst_root:/backups/Photos/
rsync $rsync_params "/Users/Aleem/Pictures/iPhoto Library" $dst_root:/backups/Photos/

# Sync iPhone backups
clear; echo "Syncing iPhone backups"
rsync $rsync_params "/Users/Aleem/Library/Application Support/MobileSync/Backup/" $dst_root:/backups/iPhone\ Backups

# Sync Home Directory Contents to NAS
clear; echo "Syncing ~ directories"
rsync $rsync_params "/Users/Aleem/Documents" $dst_root:/backups/
rsync $rsync_params "/Users/Aleem/Desktop/" $dst_root:/backups/MacDesktop
rsync $rsync_params "/Users/Aleem/Dropbox" $dst_root:/backups/

# Sync up old Xcode Archives so that they can be cleared out from this system.
clear; echo "Syncing old Xcode Archives"
rsync $rsync_params "/Users/Aleem/Library/Developer/Xcode/Archives" $dst_root:/backups/XcodeArchives

# If the external hard drive is plugged in, sync a bunch of shit from there.
if [ -d /Volumes/Games ]; then
	
	rsync $rsync_params "/Volumes/Games/EVE" $dst_root:/backups/
	# Don't sync Guild Wars because the asshole developers wrapped up like 16 gigs into a single file. 
	# rsync $rsync_params "/Volumes/Games/Guild Wars 2" $dst_root:/backups/
	# rsync $rsync_params "/Volumes/Games/Program Files \(x86\)/Steam" $dst_root:/backups/

fi

rm ".rsync_exclude"
unset RSYNC_PASSWORD
