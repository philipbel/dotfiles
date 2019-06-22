set -gx PAGER most

set -gx EDITOR vim
set -gx ALTERNATE_EDITOR nano

set -gx MANPATH /usr/local/share/man $MANPATH
if test -d ~/.man
	set -gx MANPATH ~/.man $MANPATH
end
