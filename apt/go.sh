#!/usr/bin/env bash
# Golang
# Maybe make the /usr/local/go dir beforehand and chown it?
# Seems like it's fine that root owns the directory so far.
# If Go needs to be reinstalled because a different version was requested,
#   delete the existing Go dir.
set -euf

if [ $# -ne 1 ]; then
    echo >&2 "Usage:"
    echo >&2 "  $0 <go-version>"
    exit 1
fi

GOLANG_VERSION="$1"

if [ "$(uname)" = "Linux" ]; then
    if ! type go > /dev/null || [[ "$(go version)" != *"${GOLANG_VERSION}"* ]]; then
        echo >&2 "Incorrect Golang version found. Installing $GOLANG_VERSION"
        sudo rm -rf /usr/local/go
        curl -fsSL "https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz" -o golang.tar.gz
        sudo tar -C /usr/local -xzf golang.tar.gz
        rm -f golang.tar.gz
    else
        echo >&2 "Golang ${GOLANG_VERSION} already installed."
    fi
else
    echo >&2 "Not installing Golang on this machine"
fi
