#!/bin/bash

self=`basename $0`
top_dir=$(cd `dirname $0`; pwd)

if `git --version >/dev/null`; then
    pushd "$top_dir" >/dev/null
    if [ -d .git ]; then
        echo "$self: Initializing submodules"
        git submodule init
        git submodule update
    else
        echo "$sefl: This is not a complete Git tree, cannot setup submodules"
    fi
    popd >/dev/null
else
    echo "$self: Git not found.  Vim setup will be incomplete" 
fi

MODULES=`ls -A "$top_dir" | grep -v ".git$" | grep -v .gitignore | grep -v make-links.sh | grep -v README.md`

for i in $MODULES; do
	echo "$self: Symlinking $i"
	ln -sf "$top_dir/$i" ~/
done

echo "$self: Initializing Vundle"
vim +BundleInstall +qall
