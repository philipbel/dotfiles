#!/bin/bash

self=`basename $0`
top_dir=$(cd `dirname $0`; pwd)

function msg() {
    echo -e "$self: $@"
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
fasd
most
autojump
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
*.git
.DS_Store
.config
*~"

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

function do_ln()
{
    local src=$1
    local dst=$2
    if [ -z "$src" -o -z "$dst" ]; then
        die "Usage: do_ln SRC DST"
    fi
    msg "Symlinking $src --> $dst"
    ln -sf "$src" "$dst"
    local rc=$?
    return $rc
}


function do_files()
{
    local system=$(uname -s)
    for i in $(find "$top_dir" -maxdepth 1 -name '.*'); do
        local file="$(basename $i)"
        ignored=false
        for j in $IGNORES; do
            if match "$top_dir" "$j" "$file"; then
                msg "Ignoring $file"
                ignored=true
                break
            fi
        done
        if ! $ignored; then
            do_ln "$top_dir/$file" "$HOME/$file"

            if [[ "$file" =~ .*\.$system ]]; then
                DEST=$(echo $file | sed "s/\(.*\)\.${system}/\1/")
                msg "\tPlatform-specific file $file"
                do_ln "$top_dir/$file" "$HOME/$DEST"
            fi
        fi
    done
}
do_files

################################################################################
# Config
################################################################################
function do_config()
{
    local srcdir="$top_dir/.config"
    local dstdir="$HOME/.config"
    if [ ! -d "$dstdir" ]; then
        msg "Config dir $dstdir does not exist, creating"
        mkdir -p "$dstdir"
    fi

    for i in $(find "$srcdir" -maxdepth 1); do
        local file="$(basename $i)"
        if [ "$file" = ".config" ]; then
            continue
        fi
        do_ln "$srcdir/$file" "$dstdir/$file"
    done
}
do_config


################################################################################
# Atom
################################################################################
# if ! which apm > /dev/null; then
#	msg "WARN: Atom not installed (apm not found)"
# else
#     msg "Running ~/.atom/install-packages.sh"
#     ~/.atom/install-packages.sh
# fi


################################################################################
# Vundle
################################################################################

# msg "Initializing Vundle"
# vim +BundleInstall +qall


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

