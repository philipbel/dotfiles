#!/bin/bash

self=`basename $0`


usage() {
    echo "Usage: $self COMMAND"
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi



newtab() {
    PLATFORM=`uname -s`
    case "$PLATFORM" in
        Darwin)
            osascript 2>/dev/null <<EOF
                tell application "System Events"
                   tell process "Terminal" to keystroke "t" using command down
                end
                tell application "Terminal"
                    activate
                    do script with command "cd $PWD; $*" in selected tab of the front window
                end
EOF
            return $?
            ;;
        *)
            echo "$self: Unsupported platform \`$PLATFORM'"
            return 1
            ;;
    esac
}

newtab "$@"
