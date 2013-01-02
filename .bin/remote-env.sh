#!/bin/bash

self=`basename $0`

if [ $# -lt 1 ]; then
    echo "Usage: $self [user@]host"
    exit 1
fi

SSHCMD="ssh $1 -t"

SESSIONS=$($SSHCMD tmux ls 2>/dev/null | cut -d':' -f1) || exit 1

if [ -z "$SESSIONS" ]; then
    echo "$self: No remote sessions!"
    exit 1
fi

cmdline="term-tabs.sh"
for s in $SESSIONS; do
    echo "Adding session $s"
    cmdline="$cmdline --tab $SSHCMD tmux at -t $s"
done
exec $cmdline
