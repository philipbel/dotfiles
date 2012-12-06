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
Bundle 'vim-scripts/python.vim'
Bundle 'indentpython.vim--nianyang'
" Bundle 'Shougo/neocomplcache'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'mbbill/code_complete'
Bundle 'sukima/xmledit'
Bundle 'msanders/snipmate.vim'
" Themes
Bundle 'vim-scripts/Zenburn'
Bundle 'tomasr/molokai'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set cindent

set ruler
set nobackup
set nopaste
set number
set title

set enc=utf8
if &modifiable
    set fenc=utf8
endif

colorscheme molokai

" Timeout after ESC
"set timeout
"set timeoutlen=100
set hlsearch		" highlighting
set textwidth=80
set colorcolumn=+1 " Available in Vim 7.3+
set modeline
"set formatoptions

" This enables automatic filetype detection and automatic indentation
filetype plugin indent on
syntax on

" set vim to chdir for each file <http://stackoverflow.com/a/1709267/1837715>
if exists('+autochdir')
    set autochdir
else
    autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab


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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cino+=:0 " case labels are not indented
set cino+=g0 " Place public/protected/etc. at the same level
set cino+=t0 " Don't indent func. return type
set cino+=(0 " Align cont. with the brace before
set cino+=W1s " The first param of a func. on a new line is indented by
              " shiftwidth.  The next is aligned with the prev. (see (0 above)

syn keyword type uint ubyte ulong uint64_t uint32_t uint16_t uint8_t
            \ boolean_t int64_t int32_t int16_t int8_t u_int64_t u_int32_t
            \ u_int16_t u_int8_t
            \ shared_ptr auto_ptr scoped_ptr unique_ptr


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
"autocmd BufRead *.py set smartindent
"            \ cinwords=if,elif,else,for,while,try,except,finally,def,class


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
imap <F10> <Esc>:NERDTreeToggle<CR> " NERD Tree in insert mode
" Make F3 toggle hlsearch
"nnoremap <F3> :set hlsearch!<CR>
" Remove highlighting and redraw the screen
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Make C-p and C-n navigate the tabs
nnoremap <c-p> :tabprevious<CR>
nnoremap <c-n> :tabnext<CR>
" Too fast (from <http://netbuz.org/vimrc.html>)
command! W w
command! Q q
command! Wq wq
command! WQ wq
" Don't use Ex mode, use Q for formatting
" (from <http://netbuz.org/vimrc.html>)
map Q gq

" First one is for normal mode, second one is for insert mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Command mode (from <http://stackoverflow.com/a/6923282/1837715>)
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" snipMate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:snipsAuthor = 'Philip Belemezov <philip@belemezov.net>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let local_vimrc = $HOME . '/.vimrc.local'
if filereadable(local_vimrc)
    exec "source " . local_vimrc
endif
