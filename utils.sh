# A collection of functions I may need to use throughout the bootstrapping
#   process.
# Each function should do a decent job of documenting its use.

create_symlink_and_backup() {
	if [ -z "$1" ]; then
		echo >&2 "usage: create_symlink_and_backup SOURCE DEST"
		return 1
	fi

	if [ -z "$2" ]; then
		echo >&2 "usage: create_symlink_and_backup SOURCE DEST"
		return 1
	fi

	source="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
	dest="$(cd "$(dirname "$2")" && pwd)/$(basename "$2")"

    if [ -f "$dest" ] || [ -L "$dest" ]; then
        if [ "$(readlink -- "$dest")" = "$source" ]; then
            return 0
        fi

        n_baks="$(find "$(dirname "$dest")" -iname "$(basename "$dest").bak.*" | wc -l | awk '{print $1}')"

        mv "$dest" "$dest.bak.$n_baks"
    fi

    ln -s "$source" "$dest"
}
