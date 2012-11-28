#!/bin/zsh
# ~/.zshrc
#
# zsh profiling {{{
# just execute 'ZSH_PROFILE_RC=1 zsh' and run 'zprof' to get the details
if [[ $ZSH_PROFILE_RC -gt 0 ]] ; then
    zmodload zsh/zprof
fi
# }}}

# set before sourcing /etc/profile so that if there're
# no matches, no warning is reported
setopt nullglob
[[ -e "/etc/profile" ]] && source /etc/profile
unsetopt nullglob

umask 022
# Enable core dumps of max 50K
#ulimit -c unlimited
# Disable core dumps
ulimit -c 0

## Environment
# PATH
source ~/.zsh/ccache.zsh

PATH=~/.bin:~/.local/bin:/usr/local/bin:$PATH
PATH=$_CCACHE_PATH:$PATH
PATH=/opt/local/bin:/opt/local/sbin:/sw/bin:/sw/sbin:$PATH
PATH=/sbin:/usr/sbin:/opt/bin:$PATH

# Git scripts path
PATH=$PATH:~/.git-shell-scripts.git
export PATH

#export ZLS_COLORS=$LS_COLORS

export MANPATH=/usr/local/share/man:$MANPATH
if [ -d ~/.man ]; then
	export MANPATH=~/.man:$MANPATH
fi

export CCACHE_DIR=/var/tmp/ccache
export LD_LIBRARY_PATH=~/.lib:$LD_LIBRARY_PATH:/usr/local/lib

export EDITOR=vim
export ALTERNATE_EDITOR=nano

if which most &>/dev/null; then
	export PAGER=`which most`
fi

# Email variables.  Used at least by bazaar
export EMAIL="Philip Belemezov <`whoami`@`hostname`>"
#export MAIL=~/Mail

source ~/.zsh/prompt.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/binds.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/options.zsh



# Colors attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

if which dircolors >/dev/null 2>&1; then
    eval `dircolors -b`
fi
if [ $TERM != "dumb" ]; then
	export ZLS_COLORS=$LS_COLORS
fi


# Python
export PYTHONDONTWRITEBYTECODE=1

