_CCACHE_PATHS=(/usr/lib/ccache /usr/lib64/ccache /usr/local/opt/ccache/libexec)

if [ -f "/etc/profile.d/ccache.sh" ]; then
	source "/etc/profile.d/ccache.sh"
else
	for _path in $_CCACHE_PATHS; do
	    if [ -d "$_path" ]; then
	        export _CCACHE_PATH=$_path
	    fi
	done
	PATH=$_CCACHE_PATH:$PATH
	export CCACHE_DIR=/var/tmp/ccache
fi

