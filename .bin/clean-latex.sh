#!/bin/sh

function findcmd()
{
    find . -type f \
        -name *.bbl -o \
        -name *.aux -o \
        -name *.blg -o \
        -name *.log -o \
        -name *.out
}

findcmd | xargs rm
