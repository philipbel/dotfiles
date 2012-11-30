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
Bundle 'vim-scripts/taglist.vim'
" Disable, seems to be causing problems in Ruby
" Bundle 'vim-scripts/AutoComplPop'
Bundle 'vim-scripts/vcscommand.vim'
Bundle 'vim-scripts/utl.vim'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'vim-scripts/vimspell'
Bundle 'vim-scripts/grep.vim'
" Bundle 'Shougo/neocomplcache'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'mbbill/code_complete'
Bundle 'sukima/xmledit'
" Non-GitHub repos ...
" Themes
Bundle 'vim-scripts/Zenburn'
Bundle 'tomasr/molokai'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set ruler
set nobackup
set nopaste
set number

syntax on
colorscheme molokai

set hlsearch		" highlighting
set expandtab		" Don't expand tabs
set smarttab		" Use smart tabs
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set textwidth=80
set colorcolumn=+1 " Available in Vim 7.3+
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

let g:neocomplcache_enable_at_startup = 1

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
autocmd BufRead *.py set smartindent
            \ cinwords=if,elif,else,for,while,try,except,finally,def,class

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MiniBufExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace
" See <http://vim.wikia.com/wiki/Highlight_unwanted_spaces>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace and spaces before a tab:
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/



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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:local_vimrc = '~/.vimrc.local'
if filereadable(s:local_vimrc)
    source s:local_vimrc
endif

