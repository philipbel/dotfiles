#!/bin/bash

self=`basename $0`


usage() {
    echo "Usage: $self COMMAND"
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi


linuxTab() {
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
            # See http://superuser.com/questions/94930/gnome-terminal-new-tab-dbus

            if ! which xdotool >/dev/null; then
                echo "$self: Please install xdotool"
                exit 1
            fi
            if ! which wmctrl >/dev/null; then
                echo "$self: Please install wmctrl"
                exit 1
            fi
            local wid=`xdotool search --class "$terminal" | head -1`
            # The following prints an X error, ignore
            xdotool windowfocus $wid &>/dev/null
            xdotool key ctrl+shift+t
            wmctrl -i -a $wid
            sleep 0.2 # Give the shell time to initialize

            xdotool type "$*"
            xdotool key Return
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
        Linux)
            linuxTab $*
            ;;
        *)
            echo "$self: Unsupported platform \`$PLATFORM'"
            return 1
            ;;
    esac
}

newtab "$@"
