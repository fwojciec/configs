" Set colorscheme to something nice

if ($TERM == "screen-bce") || ($TERM == "xterm-256color")
  set t_Co=256
endif

if ($TERM == "linux")
  set t_Co=8
endif

if has("gui_running")
    set guioptions=ac   
    set guifont=Envy\ Code\ R
    set lines=44
    set background=dark
    colorscheme herald
else
    set background=dark
    colorscheme herald
endif

" Disable automatic backup to prevent creation of trash all around the hard drive
set nobackup

" Enable syntax highlighting
syntax on

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" Why is this not a default
set hidden

" Don't update the display while executing macros
set lazyredraw

" At least let yourself know what mode you're in
set showmode

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
set wildmenu

" Forget being compatible with good ol' vi
set nocompatible

" Indentation / tab replacement stuff
set shiftwidth=2        " > and < move block by 4 spaces in visual mode
set tabstop=2
set sts=2
set expandtab           " expand tabs to spaces
set autoindent          " always set autoindenting on
set smartindent

" Enable backspace on Windows
set bs=2

" Keymappings
map <F2> :NERDTreeToggle<CR>    " F2 toggles NERDTree window
map <F3> :set nu!<CR>           " F3 toggles line numbers

" Set the search scan to wrap around the file
set wrapscan

" Set the forward slash to be the slash of note.  Backslashes suck
" This is really only applicable to Windows but I like to have a vimrc
" that works no matter what OS I'm currently on
set shellslash

" Make command line two lines high
set ch=2

" disable visual bell
set t_vb=

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Set encoding to utf-8
set encoding=utf8

" See :help 'cpoptions' for these ones.  'cpoptions' has a huge
" set of possible options
set cpoptions=Bces$

" Set the status line the way I like it
"set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
"set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]

" tell Vim to always put a status line in, even if there is only one
" window
set laststatus=2

" Hide the mouse pointer while typing
set mousehide

" Keep some stuff in the history
set history=100

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" When the page starts to scroll, keep the cursor 8 lines from
" the top and 8 lines from the bottom
set scrolloff=8

" Incrementally match the search.  I orignally hated this
" but someone forced me to live with it for a while and told
" me that I would grow to love it after getting used to it...
" turns out he was right :)
set incsearch

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=2048

" Mousewheel setting
set mouse=a

"autocmd settings
autocmd     FileType css                  set omnifunc=csscomplete#CompleteCSS
autocmd     BufRead,BufNewFile *.scss     set filetype=scss
autocmd     BufRead,BufNewFile *.sass     set filetype=sass
au          BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
au          BufRead,BufNewFile *.py,*.pyw set tabstop=4
au          BufRead,BufNewFile *.py,*.pyw set sts=4
au          BufRead,BufNewFile *.py,*.pyw set expandtab

if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
endif

" Call pathogen
call pathogen#infect()

