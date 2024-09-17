#!/usr/bin/env sh
#
# Set up VS Code
set -euf

CODE_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$(dirname "$CODE_DIR")" && pwd)"

# shellcheck source=..
. "$DOTFILES_DIR/utils.sh"

CODE_SETTINGS_FILE="$HOME/Library/Application Support/Code/User/settings.json"
FONT_FAMILY="'Courier Prime Code'"

outdir="$(mktemp -d)"
trap 'rm -rf "$outdir"' EXIT

curl -fsSL "https://www.1001fonts.com/download/courier-prime.zip" -o "$outdir/courier-prime.zip"
curl -fsSL "https://www.1001fonts.com/download/courier-prime-code.zip" -o "$outdir/courier-prime-code.zip"

if [ "$(uname)" = "Darwin" ]; then
	if [ -d ~/Library/Fonts/Courier-Prime ]; then
		rm -rf ~/Library/Fonts/Courier-Prime
	fi

	mkdir ~/Library/Fonts/Courier-Prime
	unzip "$outdir/courier-prime.zip" -d ~/Library/Fonts/Courier-Prime/
	unzip "$outdir/courier-prime-code.zip" -d ~/Library/Fonts/Courier-Prime/
else
	echo >&2 "Haven't tried to installed fonts on this OS. Bailing..."
	exit 1
fi

if [ "$(jq -r '."editor.fontFamily"' < "$CODE_SETTINGS_FILE")" = "$FONT_FAMILY" ]; then
	echo >&2 "VS Code font already configured"
	exit 0
fi

jq --arg "ff" "$FONT_FAMILY" -r '. + {"editor.fontFamily":$ff}' < "$CODE_SETTINGS_FILE" > "$outdir/settings.json"

replace_and_backup "$outdir/settings.json" "$CODE_SETTINGS_FILE"
