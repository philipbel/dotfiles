export PAGER=most

export EDITOR=vim
export ALTERNATE_EDITOR=nano

export MANPATH=/usr/local/share/man:$MANPATH
if [ -d ~/.man ]; then
	export MANPATH=~/.man:$MANPATH
fi

###############################################################################
# Python
###############################################################################
export PYTHONDONTWRITEBYTECODE=1
PYTHONPATH=$PYTHONPATH:~/.python.d
#for i in $(find /usr/local/lib -maxdepth 1 -type d -name 'python*'); do
#    local dir="$i/site-packages"
#    if [ -d "$dir" ]; then
#        PYTHONPATH=$PYTHONPATH:$dir
#    fi
#done
export PYTHONPATH


