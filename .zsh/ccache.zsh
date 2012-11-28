_CCACHE_PATH=/usr/lib/ccache

if [ ! -d "$_CCACHE_PATH" ]; then
    _CCACHE_PATH=/usr/lib64/ccache
fi

export _CCACHE_PATH
