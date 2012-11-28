set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
" It requires nocompatible and filetype=off
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set runtimepath+=~/.vim/vundle.git
call vundle#rc()
" Vundle itself
Bundle 'gmarik/vundle'
" Other bundles
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" required by FuzzyFinder
Bundle 'L9' 
Bundle 'FuzzyFinder'
"Bundle 'rails.vim'
" HTML/CSS Editing
" Bundle 'tristen/vim-sparkup.git' 
Bundle 'scrooloose/nerdtree'
Bundle 'wincent/Command-T'
" Syntax-sensitive comments
" 
Bundle 'tomtom/tcomment_vim'
" Non-GitHub repos



set autoindent
set ruler
set nobackup
set nopaste
set number

syntax on
colorscheme default

set hlsearch		" highlighting
set expandtab		" Don't expand tabs
set smarttab		" Use smart tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set textwidth=0
set modeline
" This enables automatic filetype detection and automatic indentation
filetype plugin indent on

" Always set the current working dir
command! CD cd %:p:h
command! LCD lcd %:p:h


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase " Override ignorecase if search contains capital letters
set incsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Omnicomplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ofu=syntaxcomplete"Complete
au BufNewFile,BufRead,BufEnter *.cpp,*.cc,*.cxx,*.hpp,*.hh,*.hxx 
    \ set omnifunc=omni#cpp#complete#Main

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set tags+=~/src/tags/systags
"set tags+=~/projects/fx/tags
" Look for "tags" in the current dir and continue looking up the tree until /
" Or going up home: set tags+=tags;$HOME
set tags+=./tags;/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LaTeX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Tex_ViewRule_dvi = 'evince'
let g:Tex_ViewRule_ps = 'evince'
let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_Folding = 0
let g:Tex_AutoFolding = 0
let g:Tex_DefaultTargetFormat = 'pdf'



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufRead,BufNewFile *.py syntax on
"autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MiniBufExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OS X
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable mouse support (on OS X requires SIMBL and mouseterm)
if has("mouse")
    set mouse=a
endif

" On OS X and Windows, use the clipboard
set clipboard=unnamed


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F10> :NERDTreeToggle<CR>
imap <F10> <Esc>:NERDTreeToggle<CR> # NERD Tree in insert mode
