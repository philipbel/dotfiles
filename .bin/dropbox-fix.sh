#!/bin/bash

self=$(basename $0)

if [ $(uname -s) != "Darwin" ]; then
    echo "$self: This script only works on OS X"
    exit 1
fi

APP_DIR=/Applications/Dropbox.app

if [ ! -d "$APP_DIR" ]; then
    APP_DIR="~/Applications/Dropbox.app"
    if [ ! -d "$APP_DIR" ]; then
        echo "$self: Dropbox.app not found in /Applications " \
            "or in ~/Applications"
        exit 1
    fi
fi

echo "$self: Dropbox found: $APP_DIR"


TO_REMOVE="DropboxBundle.bundle.tgz
DropboxHelperInstaller.tgz
DropboxPlugin.plugin.tgz
FinderLoadBundle.tgz
/Library/DropboxHelperTools"


for i in $TO_REMOVE; do
    item=""
    if [[ "$i" = /* ]]; then
        # absolute, no change
        item="$i"
    else
        # relative, prepend the app bundle path
        item="$APP_DIR/Contents/Resources/$i"
    fi
    if [ -f "$item" ]; then
        echo "$self: Trashing $item"
        mv -f "$item" "$HOME/.Trash"
    fi
done

killall Finder

echo "$self: Dropbox fixed!"
