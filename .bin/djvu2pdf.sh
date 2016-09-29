#!/bin/bash

# From: http://superuser.com/a/596167
# Modifications Copyright (c) 2016 Philip Belemezov

# convert DjVu -> PDF
# usage:  djvu2pdf.sh  <file.djvu>

SELF=$(basename $0)

usage() {
	echo "$SELF DJVU_FILE"
}


DJVU_FILE="$1"
test -n "$DJVU_FILE" || (usage ; exit 1)

if ! hash ddjvu; then
	echo "$SELF: ddjvu not found in your PATH"
	exit 2
fi


PDF_FILE=${DJVU_FILE%.djvu}.pdf

echo "$SELF: Converting ${DJVU_FILE} to ${PDF_FILE}"
ddjvu -format=pdf -quality=85 -skip ${DJVU_FILE} ${PDF_FILE} \
	|| (echo "$SELF: ddjvu failed with exit code $?" ; exit 3)
