#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: restore.sh <server ip>"
    exit 1
fi

# "Session" variables to clean up the script.
remote_host=$1

do_restore() {
    # Escape spaces
    local_path="$2"
    remote_path=$(echo $1 | sed 's/ /\\ /g')
    rsync -ahuDH --progress "rsync@$remote_host:/share$remote_path" "$local_path"
}

echo "Restoring Documents and Desktop. All other backups should be restored manually."

# Sync Home Directory Contents back to the Mac
echo "Syncing ~ directories"
do_restore "/backups/Documents/" "$HOME/Documents/" 
do_restore "/backups/MacDesktop/" "$HOME/Desktop/" 
