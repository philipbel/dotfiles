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
    echo "$self: Connecting to $HOST"
else
    echo "$self: Local connection"
fi


OUTPUT=$($CMD tmux ls)
if [ $? -gt 0 ]; then
    echo "$self: Error obtaining sessions"
    exit 1
fi

SESSIONS=$(echo "$OUTPUT" | cut -d':' -f1)

if [ -z "$SESSIONS" ]; then
    echo "$self: No remote sessions, output from tmux was:"
    exit 1
fi

cmdline="term-tabs.sh"
for s in $SESSIONS; do
    echo "Adding session $s"
    cmdline="$cmdline --tab $CMD tmux at -d -t $s"
done
$cmdline
