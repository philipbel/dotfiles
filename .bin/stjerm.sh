#!/bin/bash

stjerm \
    -k f12 \
    -fn "DejaVu Sans Mono 12" \
    -bg black \
    -fg white \
    -b thin \
    -o 85 \
    -w "70%" \
    -h "60%" \
    -s right \
    -l 5000 \
    -tl "Shell" \
    -tf false \
    -sc false \
    -ar true \
    -ub false \
    -uc green \
    $*
