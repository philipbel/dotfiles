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

for s in $SESSIONS; do
    echo "Opening session $s"
    term-newtab.sh $SSHCMD tmux at -t $s
done
