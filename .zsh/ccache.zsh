_CCACHE_PATHS=(/usr/lib/ccache /usr/lib64/ccache /usr/local/opt/ccache/libexec)

for _path in $_CCACHE_PATHS; do
    if [ -d "$_path" ]; then
        export _CCACHE_PATH=$_path
    fi
done

