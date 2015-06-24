"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vi Improved configuration
" @author Adrian Bacircea
"
" Inspired from
" - ddvlad
" - Alexandru Mosoi
" - Cosmin Ratiu
" - alexj
" - Bee
" - amix@amix.dk (amix the lucky stiff)
"   amix.dk/vim/vimrc.html
" - michaeljsmalley - https://github.com/michaeljsmalley
" - Jose Elena Campana - https://github/jelera
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 0. Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle should handle itself
Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'elzr/vim-json'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'plasticboy/vim-markdown'
Plugin 'rking/ag.vim'
Plugin 'hdima/python-syntax'
Plugin 'wting/rust.vim'
Plugin 'thynson/Cpp11-Syntax-Support'
Plugin 'vim-scripts/LargeFile'

" color schemes
"Plugin 'flazz/vim-colorschemes'
"Plugin 'vim-scripts/ScrollColors'
"Plugin 'godlygeek/csapprox'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Activate autowrite
set autowrite
" Activate autoread
set autoread

" Automatically use the current file's directory as the working directory
set autochdir

set shortmess=atToOI

" Directories for backup and swap
set backupdir=/tmp
set directory=/tmp

" More tabs
set tabpagemax=20

" Persistent undo
set undodir=~/.vim_runtime/undodir
set undofile
set undolevels=1000  " maximum number of changes that can be undone
set undoreload=10000

" Disable sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Highlight current line
"set cursorline

set mouse=a

set hidden

" Activate enhanced command completion
set wildmenu
set wildmode=full

" Set command line history
set history=50
set showcmd

" Encoding
set encoding=utf-8
set termencoding=utf-8


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 2. Events
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn file type detection on
filetype plugin on
filetype plugin indent on

" Trim trailing whitespaces on save
" set up filter for files that we don't want trimming on
autocmd FileType vim,markdown let b:noTrimm = 1

autocmd BufWritePre *
  \ if !exists("b:noTrimm") |
  \   :%s/\s\+$//e |
  \ endif

" Jump to last know location in the file on open
autocmd BufReadPost *
  \ if line ("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
" Parse .g files as antlr files
autocmd BufRead,BufNewFile *.g set filetype=antlr3

autocmd FileType text setlocal textwidth=78

" we don't want tabs to expand to spaces for certain files
autocmd FileType make setlocal noexpandtab
autocmd FileType haskell setlocal noexpandtab

" enable auto complete
"set ofu=syntaxcomplete#Complete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 3. Theme/Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn syntax highlighting on
syntax on

" Enable 256-color mode
set t_Co=16
set background=dark
colorscheme solarized

" Highlight characters that go over 80 columns
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4. ViM UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setup status line
" set statusline=%<%f\ %y%h%m%r%=%-24(0x%02B\(%03b\)\ \L\:%l/%L\ %c%V%)\ %P
set laststatus=2 " last windows always has a statusline

" always show info along bottom
set ruler

" Ignore case when searching
set ignorecase
" except for searches that contain upper case characters
set smartcase

" Highlight while typing
set incsearch
" don't continue to highlight searched phrases after
set nohlsearch

set showmatch
set mat=2

" Highlight current line
set cul

" Show line numbers
set number

" Open new vertical splits to the right of current one.
set splitright

set ttyfast
set lazyredraw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5. Text Formatting/Layout
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Activate auto-indent
set autoindent
set smartindent
set cindent
set cinoptions=g-1

" Set tab and indent width
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Expand tabs to spaces
set expandtab

set encoding=utf-8

set backspace=2

set nowrap
set textwidth=0
set wrapmargin=0

" Mark tabs and spaces
set list listchars=tab:»\ ,trail:·,extends:»,precedes:«

" Add modeline functionality
set modeline

if has('gui_running')
    set guifont=Fixed\ 11
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 6. Function definitions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! VarExists(var, val)
  if exists(a:var) | return a:val | else | return '' | endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 7. ViM Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""

" set map leader
let mapleader = ","
let g:mapleader = ','

"" buffers and split windows
nmap        <Leader>1   :enew<CR>
nmap        <Leader>2   :e 
nmap        <Leader>3   :vnew<CR>
nmap        <Leader>4   :vnew 

"" Move through tabs and windows
nnoremap    <Tab>       <C-w>w
map         <C-Left>    <ESC>:bp<CR>
map         <C-Right>   <ESC>:bn<CR>
imap        <C-Left>    <ESC><C-Left>
imap        <C-Right>   <ESC><C-Right>

"" Forced commands
nmap        <Leader>w   :w!<CR>
nmap        <Leader>q   :q!<CR>

" indent file
map         <Leader>i   <ESC>gg=G

"" Function keys
nmap        <F2>        :NERDTreeTabsToggle<CR>
imap        <F2>        <ESC><F2>

""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Versioning Systems plugins' options
""

if has("vms")
  set nobackup
else
  set backup
endif

""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Latex
"" TODO reorganize vimrc
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "xelatex"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
