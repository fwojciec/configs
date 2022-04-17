" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')
" tpope is a separate category
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'

" interface
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" quality of life
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-rooter'
" Plug 'junegunn/vim-slash'

" Custom
Plug 'fwojciec/vim-go-motion'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'blueyed/smarty.vim'

" Testing
Plug 'vim-test/vim-test'

" Neovim lua lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" language support
Plug 'rhysd/vim-go-impl'
" Plug 'rust-lang/rust.vim'
" Plug 'vim-python/python-syntax'
" Plug 'vim-scripts/indentpython.vim'
" Plug 'jparise/vim-graphql'
" Plug 'pangloss/vim-javascript'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'leafgarland/typescript-vim'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'lifepillar/pgsql.vim'
" Plug 'cespare/vim-toml'
" Plug 'uarun/vim-protobuf'
" Plug 'martinda/Jenkinsfile-vim-syntax'
" Plug 'neovimhaskell/haskell-vim'
" Plug 'elixir-editors/vim-elixir'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'cousine/go-present-slide-syntax.vim'
" Plug 'euclidianAce/BetterLua.vim'
call plug#end()
" }}}

" General settings {{{
syntax on

set guicursor=
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
set termguicolors
set scrolloff=5
set noshowmode
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set signcolumn=number " no need for gutter to display diagnostics info
set mouse=a
set noemoji
set updatetime=50
set clipboard+=unnamedplus
if exists('&inccommand')
    set inccommand=split
endif
set cursorline
" set showtabline=2
" set winwidth=100
" set re=0 " see https://github.com/HerringtonDarkholme/yats.vim#config
" }}}

" Fast startup {{{
let g:python3_host_prog = expand("$HOME").'/.pyenv/versions/3.9.0/bin/python'
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
" set background=dark
" let g:gruvbox_underline = 0
" let g:gruvbox_bold = 0
" let g:gruvbox_invert_selection = 0
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
" }}}

" FileType AutoCommands {{{
augroup AutoCommands
    autocmd!
    autocmd BufWritePost init.vim nested so $MYVIMRC
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

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
let g:fzf_layout = { 'down': '~40%' }
" }}}

" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'lsp', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'FugitiveHead',
      \   'lsp': 'LspStatus',
      \ }
      \ }

function! LspStatus() abort
    return luaeval("require('lsp-status').status()")
endfunction

augroup LightLineAutocommands
    autocmd!
    autocmd User LspDiagnosticsChanged call lightline#update()
augroup end
" }}}

" Terminal {{{
augroup TerminalStuff
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber winwidth&
augroup end
" }}}

" {{{ vim-highlightedyank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
" }}}

" vim-test {{{
let test#strategy = 'neovim'
" }}}

" vim-dispatch {{{
let g:dispatch_no_maps = 1 " no default mappings
" let g:dispatch_no_tmux_make = 1 " don't open using tmux split
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

" don't use arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" terminal
" tnoremap <Esc> <C-\><C-n>
nmap <silent><leader>` :belowright 15split term://zsh \|:startinsert<CR>
" }}}

" Vsnip {{{
let g:vsnip_snippet_dir = expand('$HOME/.config/nvim/vsnip')

" Expand
imap <expr> <C-s>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-s>'
smap <expr> <C-s>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-s>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Snippet jump forward or backward
imap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-j>'
smap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-j>'
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
" nmap        s   <Plug>(vsnip-select-text)
" xmap        s   <Plug>(vsnip-select-text)
" nmap        S   <Plug>(vsnip-cut-text)
" xmap        S   <Plug>(vsnip-cut-text)
" }}}

" Nvim lua lsp {{{
lua require("lsp")

let g:diagnostic_enable_underline = 0
let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_sorting = 'none'
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['fuzzy', 'exact']

" completion_nvim
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <silent> <C-Space> <Plug>(completion_trigger)
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" inoremap <silent><expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <silent><expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" inoremap <silent><expr> <Tab>      pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <silent><expr> <S-Tab>    pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <silent><expr> <C-Space>  <C-x><C-o>
" }}}
