#!/bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: restore.sh <server ip> <password>"
fi

# "Session" variables to clean up the script.
ip_address=$1
export RSYNC_PASSWORD=$2

do_restore() {
    rsync -ahuDH --progress "rsync://rsync@$ip_address:$1" "$2"
}

echo "Restoring Documents and Desktop. All other backups should be restored manually."

# Sync Home Directory Contents back to the Mac
clear; echo "Syncing ~ directories"
do_restore "/backups/Documents/" "$HOME/Documents/" 
do_restore "/backups/MacDesktop/" "$HOME/Desktop/" 

unset RSYNC_PASSWORD
