#!/bin/bash

self=`basename $0`


usage() {
    echo "Usage: $self COMMAND"
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

SCRIPTS=
CURSCRIPT=
while [ $# -gt 0 ]; do
    if [ "$1" = "--tab" ]; then
        SCRIPTS="$SCRIPTS:$CURSCRIPT"
        CURSCRIPT=
    else
        CURSCRIPT="$CURSCRIPT $1"
    fi
    shift
done
SCRIPTS="$SCRIPTS:$CURSCRIPT"



linuxOpenTabs() {
    pushd $PWD >/dev/null

    local de=
    local terminal=

    # see .zsh/alias.zsh
    if [ -n "$KDE_SESSION_VERSION" ]; then
        de=kde
        terminal=konsole
        echo "$self: KDE not supported"
        exit 1
    elif [ "$DESKTOP_SESSION" = "gnome" ]; then
        de=gnome
        terminal=gnome-terminal
    elif [ "$DESKTOP_SESSION" = "mate" ]; then
        de=mate
        terminal=mate-terminal
    elif [ "$DESKTOP_SESSION" = "xfce" ]; then
        de=xfce
        terminal=xfce-terminal
        echo "$self: XFCE not supported"
        exit 1
    else
        echo "$self: Unsupported desktop environment"
    fi

    case $de in
        mate|gnome)
            params=
            IFS=':'
            for i in $SCRIPTS; do
                if [ -z "$i" ]; then
                    continue
                fi
                params="$params --tab -e \"$i\""
            done
            $terminal $params
            ;;
        *)
            echo "$self: Unknown desktop environment"
            exit 1
    esac
    popd >/dev/null
}

tabStringMac() {
    read -rd '' str <<EOF

    tell application "System Events"
        tell process "Terminal" to keystroke "t" using command down
    end
    tell application "Terminal"
        activate
        do script with command "cd $PWD; $*" in selected tab of the front window
    end

EOF
    echo "$str"
    return 0
}

newtab() {
    PLATFORM=`uname -s`
    case "$PLATFORM" in
        Darwin)
            local params=
            #local params="osascript 2>/dev/null"
            IFS=':'
            for i in $SCRIPTS; do
                if [ -z "$i" ]; then
                    continue
                fi
                params="$params $(tabStringMac $i)"
            done
            osascript -e "$params"
            return $?
            ;;
        Linux)
            linuxOpenTabs $*
            return $?
            ;;
        *)
            echo "$self: Unsupported platform \`$PLATFORM'"
            return 1
            ;;
    esac
}

newtab "$@"
