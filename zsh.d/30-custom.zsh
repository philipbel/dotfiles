export PAGER=most

export EDITOR=vim
export ALTERNATE_EDITOR=nano

export MANPATH=/usr/local/share/man:$MANPATH
if [ -d ~/.man ]; then
	export MANPATH=~/.man:$MANPATH
fi
