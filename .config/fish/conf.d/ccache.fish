set -gx _CCACHE_PATHS /usr/lib/ccache /usr/lib64/ccache /usr/local/opt/ccache/libexec

for _path in $_CCACHE_PATHS
    if test -d "$_path"
        set -gx PATH $_path $PATH
        set -gx CCACHE_DIR /var/tmp/ccache
        break
    end
end
