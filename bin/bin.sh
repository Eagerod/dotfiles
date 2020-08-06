#!/usr/bin/env sh
#
# Link all files in this directory, other than this file to /usr/local/bin.

DEST_DIR=/usr/local/bin
BIN_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_FILE="$(basename "$0")"

find "$BIN_DIR" -mindepth 1 -maxdepth 1 -type f -print | sed "s:^${BIN_DIR}/::" | grep -v "^${BIN_FILE}$" | while read line; do
    # Skip any files that don't have an executable bit on them.
    if [ ! -x "$BIN_DIR/$line" ]; then
        continue
    fi
    rm "$DEST_DIR/$line" 2> /dev/null
    ln -s "$BIN_DIR/$line" "$DEST_DIR/$line"
done

