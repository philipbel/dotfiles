#!/usr/bin/env bash

# BASE_TEMP_DIR=/tmp
# TEMP_DIR=$(mktemp -d $BASE_TEMP_DIR/google-chome.XXXXXXX)

URL="http://localhost:8000"

DIR=$(mktemp -d)
OPTS="--disable-cache --no-first-run"

mkdir -p "$DIR"

CHROME_APP="/Applications/Chrome.app/Contents/MacOS/Google Chrome"

if [ -n "$1" ]; then
  URL="$1"
fi

if [ $(uname -s) == "Darwin" ]; then
  "$CHROME_APP" --user-data-dir="$DIR" $OPTS "$URL" >/dev/null
else
  chromium --user-data-dir="$DIR" $OPTS "$URL" >/dev/null
fi
