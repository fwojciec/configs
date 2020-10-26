" Plugins {{{
call plug#begin('~/.vim/plugged')
" tpope is a separare category
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'

" Interface
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'machakann/vim-highlightedyank'

" FZF
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Language support
Plug 'govim/govim'

" Testing
Plug 'vim-test/vim-test'

" Snippets
Plug 'SirVer/ultisnips'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'blueyed/smarty.vim'
call plug#end()
" }}}

" General settings {{{
syntax on

set number
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set smartcase
set nobackup
set noswapfile
set undodir=~/.local/share/nvim/.vimdid
set undofile
set incsearch
set scrolloff=5
set noshowmode
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set signcolumn=number " no need for gutter to display diagnostics info
set mouse=a
set noemoji
set updatetime=50
set clipboard+=unnamed
" }}}

" Fast startup {{{
let g:python3_host_prog = expand("$HOME").'/.pyenv/versions/3.8.5/bin/python'
let g:python_host_prog = expand("$HOME").'/.pyenv/shims/python2'
let g:ruby_host_prog = expand("$HOME").'/.gem/ruby/2.7.0/bin/neovim-ruby-host'
let g:node_host_prog = '/usr/local/lib/node_modules/neovim/bin/cli.js'
" }}}

" Colorscheme {{{
if (has("termguicolors"))
	" set Vim-specific sequences for RGB colors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif
set background=dark
" let g:gruvbox_italic = 1
let g:gruvbox_bold = 0
let g:gruvbox_invert_selection = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
" }}}

" FileType AutoCommands {{{
augroup AutoCommands
    autocmd!
    autocmd BufWritePost .vimrc nested so $MYVIMRC
    autocmd FileType html setlocal tabstop=2 shiftwidth=2
    autocmd FileType json setlocal tabstop=2 shiftwidth=2
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
    autocmd FileType toml setlocal tabstop=2 shiftwidth=2
    autocmd FileType css setlocal tabstop=2 shiftwidth=2
    autocmd FileType scss setlocal tabstop=2 shiftwidth=2
    autocmd FileType vim setlocal tabstop=4 shiftwidth=4 foldmethod=marker
    autocmd BufNewFile,BufRead *.hs setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.hsc setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.lhs setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cabal setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.scala setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.sbt setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.pgsql setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.js setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 shiftwidth=2 filetype=javascript.tsx
    autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.tsx setlocal tabstop=2 shiftwidth=2 filetype=typescript.tsx
    autocmd BufNewFile,BufRead ~/Work/www/templates/**/*.html setlocal tabstop=4 shiftwidth=4 filetype=smarty

    " Jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif
augroup end
" }}}

" FZF settings {{{
let g:fzf_colors =
\ { "fg":      ["fg", "Normal"],
  \ "bg":      ["bg", "Normal"],
  \ "hl":      ["fg", "IncSearch"],
  \ "fg+":     ["fg", "CursorLine", "CursorColumn", "Normal"],
  \ "bg+":     ["bg", "CursorLine", "CursorColumn"],
  \ "hl+":     ["fg", "IncSearch"],
  \ "info":    ["fg", "IncSearch"],
  \ "border":  ["fg", "Ignore"],
  \ "prompt":  ["fg", "Comment"],
  \ "pointer": ["fg", "IncSearch"],
  \ "marker":  ["fg", "IncSearch"],
  \ "spinner": ["fg", "IncSearch"],
  \ "header":  ["fg", "WildMenu"] }

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
" let g:fzf_layout = { 'down': '~40%' }
" }}}

" Hightlighted Yank {{{
let g:highlightedyank_highlight_duration = 50
" }}}

" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'FugitiveHead',
      \ }
      \ }
" }}}

" vimgo {{{
call govim#config#Set("HighlightReferences", 0)
call govim#config#Set("Staticcheck", 1)
" }}}

" Mappings {{{
let mapleader=' '

" fzf
nnoremap <silent><leader><leader> :GitFiles<CR>
nnoremap <silent><leader><CR>     :Buffers<CR>
nnoremap <silent><leader>fi       :Files<CR>
nnoremap <silent><leader>fl       :Lines<CR>
nnoremap <silent><leader>ag       :Ag<CR>

" better paste
vnoremap p "_dP

" govim
nnoremap <silent> <buffer> K :call GOVIMHover()<CR>
nnoremap <silent> <buffer> <leader>gr :call :GOVIMReferences<CR>
nnoremap <silent> <buffer> <leader>gt :call :GOVIMGoToTypeDef<CR>
nnoremap <silent> <buffer> <leader>gi :call :GOVIMImplements<CR>
nnoremap <silent> <buffer> <leader>rn :call :GOVIMRename<CR>
inoremap <silent> <buffer> <C-k> :call :GOVIMExperimentalSignatureHelp<CR>


" don't use arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Omnicomplete
inoremap <silent><expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <silent><expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <silent><expr> <Tab>      pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab>    pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-Space>  <C-x><C-o>
" }}}
