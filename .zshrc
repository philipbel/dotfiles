#!/bin/zsh
# ~/.zshrc
#
# zsh profiling {{{
# just execute 'ZSH_PROFILE_RC=1 zsh' and run 'zprof' to get the details
if [[ $ZSH_PROFILE_RC -gt 0 ]] ; then
    zmodload zsh/zprof
fi
# }}}

case `uname -s` in
    Darwin)
        IS_DARWIN=1
        ;;
    Linux)
        IS_LINUX=1
        ;;
    *)
        echo "Unknown platform"
        exit 1
        ;;
esac

export TERM="xterm-256color"

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


###############################################################################
## Environment
###############################################################################

# PATH
PATH=~/.bin:~/bin:~/opt/bin;~/.local/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
# ccache
source ~/.zsh/ccache.zsh
PATH=$_CCACHE_PATH:$PATH
export CCACHE_DIR=/var/tmp/ccache

if [ -d ~/Library/Python/2.7/bin ]; then
    PATH=~/Library/Python/2.7/bin:$PATH
fi

# Git scripts path
PATH=$PATH:~/.git-shell-scripts.git
export PATH

#export ZLS_COLORS=$LS_COLORS

# MANTPATH

export MANPATH=/usr/local/share/man:$MANPATH
if [ -d ~/.man ]; then
	export MANPATH=~/.man:$MANPATH
fi


if [ "$IS_DARWIN" != "1" ]; then
    export LD_LIBRARY_PATH=~/.lib:$LD_LIBRARY_PATH:/usr/local/lib
fi

export EDITOR=vim
export ALTERNATE_EDITOR=nano

#if which vimpager &>/dev/null; then
#    export PAGER=vimpager
#elif which most &>/dev/null; then
	export PAGER=most
#fi

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


###############################################################################
# Python
###############################################################################
export PYTHONDONTWRITEBYTECODE=1
for i in $(find /usr/local/lib/ -maxdepth 1 -type d -name 'python*'); do
    local dir="$i/site-packages"
    if [ -d "$dir" ]; then
        PYTHONPATH=$dir:$PYTHONPATH
    fi
done
export PYTHONPATH


###############################################################################
# Local file
###############################################################################
LOCAL_ZSHRC="$HOME/.zshrc.local"
if [ -r "$LOCAL_ZSHRC" ]; then
    source "$LOCAL_ZSHRC"
fi
