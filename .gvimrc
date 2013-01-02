if has('win32')
elseif has('mac')
    set guifont=Monaco:h11
    let g:Tex_ViewRule_pdf = 'Preview'
    set macmeta
elseif has('unix')
    set guifont=DejaVu\ Sans\ Mono\ 11
endif

set guicursor+=a:blinkon0 " a means all mods
set guioptions-=T  "remove toolbar
