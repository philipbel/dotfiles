#!/bin/bash

self=`basename $0`
top_dir=$(cd `dirname $0`; pwd)

function msg() {
    echo "$self: $@"
}

function die() {
    msg "Error: $@"
    exit 1
}

################################################################################
# Requirements
################################################################################

REQUIRED_EXECUTABLES="
ruby
make
perl
ctags
git
hg
"
function show_required_packages() {
    msg "*************************************************************************"
    msg "You need the following packages:"
    msg "- ruby"
    msg "- ruby-dev (mkmf module)"
    msg "- exuberant-ctags"
    msg "- git"
    msg "- mercurial (hg)"
    msg "*************************************************************************"
}

for i in $REQUIREMENTS; do
    if ! `which $i > /dev/null`; then
        msg "$i not found on your system"
        show_required_packages
        exit
    fi
done

################################################################################
# Git
################################################################################

if `git --version >/dev/null`; then
    pushd "$top_dir" >/dev/null
    if [ -d .git ]; then
        msg "Initializing submodules"
        git submodule init
        git submodule update
    else
        msg "This is not a complete Git tree, cannot setup submodules"
    fi
    popd >/dev/null
else
    msg "Git not found.  Vim setup will be incomplete" 
fi

################################################################################
# Symlinks
################################################################################

IGNORES="setup.sh
README.md
*.swp
*.git"

# Test for a glob match
# $1 - dir to check in
# $2 - pattern to check for
# $3 - path to test for match
function match() {
    # resolve ~
    eval dir=$1
    local pattern=$2
    eval path=$3

    local result=$(find "$dir" -maxdepth 1 -name "$pattern" -print -quit)
    echo "result = $result"
    if $(echo $result | grep $path); then
	echo "match"
	return 0
    else
	echo "no match"
	return 1
    fi
}

for i in `ls -A "$top_dir"`; do
    for j in $IGNORES; do
	if match "$top_dir" "$j" "$i"; then
	    msg "Ignoring $i"
	    continue
	fi
        msg "Symlinking $i"
        ln -sf "$top_dir/$i" ~/
    done
done

exit


################################################################################
# Vundle
################################################################################

msg "Initializing Vundle"
vim +BundleInstall +qall


################################################################################
# Command-T
# Requires Vim with Ruby support, Ruby, rake
################################################################################

COMMANDT_DIR="$top_dir/.vim/bundle/Command-T/ruby/command-t"
msg "Setting up Command-T"

pushd "$COMMANDT_DIR" >/dev/null \
    || die "Cannot enter Command-T dir $COMMANDT_DIR"
ruby extconf.rb || die "Failed to configure Command-T"
make || die "Make failed"
popd >/dev/null

msg "Command-T successfully set up"

