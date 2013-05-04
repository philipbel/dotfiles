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
make
ctags
git
hg
"
function show_required_packages() {
    msg "*************************************************************************"
    msg "You need the following packages:"
    for e in $REQUIRED_EXECUTABLES; do
	msg "- $p"
    done
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
# Emacs
################################################################################

EMACS_PACKAGE_DIR="$top_dir/.emacs.d/el-get"

msg "Removing Emacs package directory: $EMACS_PACKAGE_DIR"
rm -rf "$EMACS_PACKAGE_DIR"


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
    msg "Git not found. Setup will be incomplete"
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
    local dir="$(cd $1; pwd)"
    local pattern="$2"
    local path="$3"

    local result=$(find "$dir" -maxdepth 1 -name "$pattern" -print -quit)
    if echo $result | grep $path >/dev/null; then
        return 0
    else
        return 1
    fi
}

for i in `ls -A "$top_dir"`; do
    ignored=false
    for j in $IGNORES; do
        if match "$top_dir" "$j" "$i"; then
            msg "Ignoring $i"
	    ignored=true
	    break
        fi
    done
    if ! $ignored; then
        msg "Symlinking $i"
        ln -sf "$top_dir/$i" ~/
    fi
done

################################################################################
# Vundle
################################################################################

msg "Initializing Vundle"
vim +BundleInstall +qall


################################################################################
# Command-T
# Requires Vim with Ruby support, Ruby, rake
################################################################################

# COMMANDT_DIR="$top_dir/.vim/bundle/Command-T/ruby/command-t"
# msg "Setting up Command-T"

# pushd "$COMMANDT_DIR" >/dev/null \
#     || die "Cannot enter Command-T dir $COMMANDT_DIR"
# ruby extconf.rb || die "Failed to configure Command-T"
# make || die "Make failed"
# popd >/dev/null

# msg "Command-T successfully set up"

