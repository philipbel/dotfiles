#!/usr/bin/env bash

# BASE_TEMP_DIR=/tmp
# TEMP_DIR=$(mktemp -d $BASE_TEMP_DIR/google-chome.XXXXXXX)

URL="http://localhost:8000"

DIR="~/tmp/chrome-dev"
OPTS="--disable-cache --no-first-run"

mkdir -p "$DIR"
chromium --user-data-dir="$DIR" $OPTS "$URL"
