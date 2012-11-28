#!/bin/zsh

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'


alias ~='cd ~'
alias /='cd /'


# ls color output work differently on Darwin
if [ `uname -s` = "Darwin" -o `uname -s` = "FreeBSD" ]; then
	_LS_COLOR_OPT_ON="-G"
	_LS_COLOR_OPT_OFF=""
else
	_LS_COLOR_OPT_ON="--color=auto"
	_LS_COLOR_OPT_OFF="--color=none"
fi



if [ $TERM = "dumb" ]; then
   	alias ls='ls ${_LS_COLOR_OPT_OFF} -h'
	alias grep='grep --color=none'
	alias egrep='egrep --color=none'
else
	alias ls='ls ${_LS_COLOR_OPT_ON} -h'
   	alias grep='grep --color=auto'
   	alias egrep='egrep --color=auto'
fi


alias l='ls -lA'
alias la='ls -la'
alias m='most'
alias less='command less -r'
alias le='less'
alias ka='killall'

alias findf='find . -type f -name '

alias xx='chmod +x'

alias N='&>/dev/null&'

# Applications
alias blender='blender -w'
alias kdbg='kdbg >/dev/null 2>&1'
alias ddd='ddd >/dev/null 2>&1'
alias gdb='gdb -q'

# Git
if [ `uname -s` = "Darwin" -a -d /Applications/GitX.app ]; then
    alias gitx='open -a GitX'
else
    alias gitx='gitk >/dev/null'
fi
alias gitka='gitk --all'
alias g='git'
alias gn='git --no-pager'
alias gp='git --paginate'

alias lh='cat /etc/hosts'

# On Darwin, prefer Emacs.app, if it's available
if [ `uname -s` = "Darwin" ]; then
	if [ -x /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
		alias emacs='open /Applications/Emacs.app'
	fi
fi
alias e=emacs
alias em='emacs --no-window-system'
alias emm='emacs --no-init-file --no-site-file --no-window-system'
alias ec='emacsclient --no-wait'

alias igrep='grep -i'

function psg()
{
    ps -ax | grep -i $@
}

function fileManager
{
	if [ `uname -s` = "Darwin" ]; then
		local finder="/System/Library/CoreServices/Finder.app"
		if [ -x "$finder/Contents/MacOS/Finder" ]; then
			command open "$finder" $@
		else
			echo "fileManager(): Warning: Could not find Finder"
		fi
	elif [ `uname -s` = "Linux" ]; then
		# KDE_SESSION_VERSION is better than DESKTOP_SESSION, which could be
		# for example ``default''
		if [ -n "$KDE_SESSION_VERSION" ]; then
			command dolphin $@
		elif [ "$DESKTOP_SESSION" = "gnome" ]; then
			command nautilus $@
		elif [ "$DESKTOP_SESSION" = "xfce" ]; then
			command thunar $@
		else
			echo "fileManager(): Warning: There is no supported file manager"
		fi
	fi
}
alias fm='fileManager'
alias f='fm . >/dev/null 2>&1 &'

function dict()
{
    grep -i $1 /usr/share/dict/words
}

function refresh()
{
    source ~/.zshrc
    rehash
}

function mdcd()
{
	mkdir -p $1 && cd $1
}

# $1 = Directory to delete
function delme()
{
	if [ -z "$1" ]; then
		echo "Usage: delme DIR"
		return
	fi
	local DIR=$(TMPDIR='' mktemp --dry-run -p '' -t delme-XXXXXX)
	echo Moving $1 to $DIR
	mv $1 $DIR
	echo Deleting $DIR
	nice rm -rf $DIR
	echo $DIR removed
}


# Package management
if which aptitude >/dev/null 2>&1; then
    alias pkgi='sudo aptitude install'
    alias pkgr='sudo aptitude remove'
    alias pkgu='sudo aptitude update'
    alias pkgupg='sudo aptitude upgrade'
    alias pkguu='pkgu && pkgupg'
    alias pkgs='aptitude source'
elif which yum >/dev/null 2>&1; then
    alias pkgi='sudo yum install'
    alias pkgr='sudo yum remove'
    alias pp='sudo yum remove'
    alias pkgu='sudo yum update'
    alias pkgupg='sudo yum upgrade'
    alias pkgs='yum search'
fi

alias rsync='rsync -avz -e ssh'

# Filter out Fedora system mounts
function mnt() {
    mount \
    | egrep -v '^(cgroup|tmpfs|systemd-1|/sys|hugetlbfs|mqueue|sunrpc|binfmt_misc|selinuxfs|devpts|udev|/proc)'
}
