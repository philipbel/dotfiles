#!/bin/bash

self=`basename $0`
top_dir=$(cd `dirname $0`; pwd)

function die() {
    echo "$self: Error: $@"
    exit 1
}


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

################################################################################
# Command-T
# Requires Vim with Ruby support, Ruby, rake
################################################################################

COMMANDT_DIR="$top_dir/.vim/bundle/Command-T/ruby/command-t"
#if [ -z "`vim --version | grep '+ruby'`" ]; then
#    echo "$self: Vim has no Ruby support, skipping"
#    return 1
#fi
#if [ ! -d "$COMMANDT_DIR" ]; then
#    echo "$self: Command-T not found in $COMMANDT_DIR";
#    return 1
#fi

test -n "`which ruby`" || die "ruby not found"
test -n "`which make`" || die "make not found"

echo "$self: Setting up Command-T"

pushd "$COMMANDT_DIR" >/dev/null \
    || die "Cannot enter Command-T dir $COMMANDT_DIR"
ruby extconf.rb || die "Failed to configure Command-T"
make || die "Make failed"
popd >/dev/null

echo "$self: Command-T successfully set up"

