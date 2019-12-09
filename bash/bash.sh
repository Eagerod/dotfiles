#!/usr/bin/env sh

DST_DIR=$HOME
SRC_DIR=$(cd $(dirname $0) && pwd)

ln -s "${SRC_DIR}/bash_profile" "${DST_DIR}/.bash_profile"
