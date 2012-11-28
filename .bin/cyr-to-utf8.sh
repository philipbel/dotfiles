#!/bin/bash

while [ $# -gt 0 ]; do
	mv "$1" "$1-backup"
	iconv -f WINDOWS-1251 -t UTF-8 "$1-backup" -o "$1"
	rm "$1-backup"
	shift
done
