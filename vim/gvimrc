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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable Vi compatibility
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General options
""
" Turn file type detection on
filetype plugin on
filetype plugin indent on

" Turn syntax highlighting on
syntax on

" Setup status line
set statusline=%<%f\ %y%h%m%r%=%-24(0x%02B\(%03b\)\ \L\:%l/%L\ %c%V%)\ %P
set laststatus=2

" Add modeline functionality
set modeline

" Activate autowrite
set autowrite

" Directories for backup and swap
set backupdir=/tmp
set directory=/tmp

" Ignore case when searching
set ignorecase
" except for searches that contain upper case characters
set smartcase

" Highlight search things
set hlsearch
set incsearch

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
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command line options
""
" Activate enhanced command completion
set wildmenu

" Set command line history
set history=50
set showcmd
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mode options
""
set encoding=utf-8

set textwidth=72
set backspace=2

" Set tab and indent width
set tabstop=2
set shiftwidth=2
" Expand tabs to spaces
set expandtab

" Open new vertical splits to the right of current one.
set splitright

set showmatch
set mat=2

" Mark tabs and spaces
set list listchars=tab:»\ ,trail:·,extends:»,precedes:«
" if above doesn't work, make sure vim was compiled with
" --enable-multibyte. vim --version should show you +multi_byte
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function definitions
""
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Commands
""
" Trim trailing whitespaces on save
" set up filter for files that we don't want trimming on
autocmd FileType vim let b:noTrimm = 1

autocmd BufWritePre *
  \ if !exists("b:noTrimm") |
    \ :%s/\s\+$//e |
  \ endif

" Jump to last know location in the file on open
autocmd BufReadPost *
  \ if line ("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

autocmd FileType text setlocal textwidth=78

" we don't want tabs to expand to spaces for makefiles
autocmd FileType make setlocal noexpandtab
autocmd FileType haskell setlocal noexpandtab
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ViM Mappings
""
" Mapping from usenet
imap jj <Esc>

" quick fixing
nnoremap <Tab>    :cnext<Cr>
nnoremap <S-Tab>  :cprev<Cr>

"map Q gq

" Space as PageDown like web browser
nmap  <Space> <PageDown>
vmap  <Space> <PageDown>

map   <F2>    <ESC>:tabnew<CR>
map   <F3>    <ESC>:tabnew<CR>:e 
imap  <F2>    <ESC><F2>i
imap  <F3>    <ESC><F2>

map   <C-Left>    <ESC>:tabp<CR>
map   <C-Right>   <ESC>:tabn<CR>
imap  <C-Left>    <ESC><C-Left>
imap  <C-Right>   <ESC><C-Right>

nmap <F5> :make<CR>
nmap <F7> :make clean<CR>
imap <F5> <ESC><F5>
imap <F7> <ESC><F7>
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source code related options
""
if has("cscope")
  " Look for a 'cscope.out' file starting from the current directory,
  " going up to the root directory.
  let s:dirs = split(getcwd(), "/")
  while s:dirs != []
    let s:path = "/" . join(s:dirs, "/")
    if (filereadable(s:path . "/cscope.out"))
      execute "cs add " . s:path . "/cscope.out " . s:path . " -v"
      break
    endif
    let s:dirs = s:dirs[:-2]
  endwhile

  set csto=0	" Use cscope first, then ctags
  set cst		" Only search cscope
  set csverb	" Make cs verbose

  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

  nmap <C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

  " Open a quickfix window for the following queries.
  set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
endif
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
