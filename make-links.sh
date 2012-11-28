#!/bin/sh

self=`basename $0`
top_dir=$(cd `dirname $0`; pwd)

MODULES=`ls -A "$top_dir" | grep -v ".git$" | grep -v .gitignore | grep -v make-links.sh | grep -v README.md`

for i in $MODULES; do
	echo Symlinking $i
	ln -sf "$top_dir/$i" ~/
done

