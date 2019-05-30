set history filename ~/.gdb_history
set history save
set history expansion on
#set follow-fork-mode child
set pagination off

set print object on
set print pretty on
set print address on
set print symbol-filename on
set print array on
set print union on
set print vtbl on


# From http://stackoverflow.com/questions/2492020/how-to-view-contents-of-stl-containers-using-gdb-7-x
python
import sys
import os.path
sys.path.insert(0, os.path.expanduser('~/.gdb.d'))
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
set startup-with-shell off
