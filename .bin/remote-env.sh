#!/bin/bash

self=`basename $0`

usage() {
    echo "Usage: $self [user@][host]"
    echo ""
    echo "When no host is given, tmux is used locally."
}

for arg in "$@"; do
    case "$arg" in
        -h|--help)
            usage
            exit 0
            ;;
        -*)
            "echo $self: Error: Unknown option \`$1'"
            usage
            exit 1
            ;;
        *)
            HOST="$arg"
            shift
            ;;
    esac
done

if [ -n "$HOST" ]; then
    CMD="ssh $HOST -t"
fi

SESSIONS=$($CMD tmux ls 2>/dev/null | cut -d':' -f1) || exit 1

if [ -z "$SESSIONS" ]; then
    echo "$self: No remote sessions!"
    exit 1
fi

cmdline="term-tabs.sh"
for s in $SESSIONS; do
    echo "Adding session $s"
    cmdline="$cmdline --tab $CMD tmux at -d -t $s"
done
$cmdline
