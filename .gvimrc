if has("win32")
elseif has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin"
        set guifont=Menlo\ 11
    else
        set guifont=DejaVu\ Sans\ Mono\ 11
    endif
endif

set guicursor+=a:blinkon0 " a means all mods
set guioptions-=T  "remove toolbar
