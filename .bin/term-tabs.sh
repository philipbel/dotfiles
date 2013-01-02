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
            cmdline="$terminal "
            IFS=':'
            for i in $SCRIPTS; do
                if [ -z "$i" ]; then
                    continue
                fi
                cmdline="$cmdline --tab -e \"$i\""
            done
            $cmdline
            ;;
        *)
            echo "$self: Unknown desktop environment"
            exit 1
    esac
    popd >/dev/null
 }


newtab() {
    PLATFORM=`uname -s`
    case "$PLATFORM" in
        Darwin)
            echo "XXX: Fix this for OS X"
#            osascript 2>/dev/null <<EOF
#                tell application "System Events"
#                   tell process "Terminal" to keystroke "t" using command down
#                end
#                tell application "Terminal"
#                    activate
#                    do script with command "cd $PWD; $*" in selected tab of the front window
#                end
#EOF
            return $?
            ;;
        Linux)
            linuxOpenTabs $*
            ;;
        *)
            echo "$self: Unsupported platform \`$PLATFORM'"
            return 1
            ;;
    esac
}

newtab "$@"
