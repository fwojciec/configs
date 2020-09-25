" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')
" tpope is a separate category
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'

" interface
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'arcticicestudio/nord-vim'
" Plug 'joshdick/onedark.vim'

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" quality of life
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-slash'
" Plug 'airblade/vim-rooter'

" Custom
Plug 'fwojciec/vim-go-motion'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'blueyed/smarty.vim'

" Testing
Plug 'vim-test/vim-test'

" Neovim lua lsp
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'euclidianAce/BetterLua.vim'
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
call plug#end()
" }}}

" General settings {{{
" I assume the vim-sensible plugin is present
set number
set relativenumber
set cursorline
set clipboard^=unnamed,unnamedplus
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=200
set shortmess+=c
set signcolumn=number " no need for gutter to display diagnostics info
set hlsearch
set ignorecase
set smartcase
set mouse=a
set noshowmode " hide -- INSERT --
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=5
set completeopt=menuone,noinsert,noselect
" set showtabline=2
if exists('&inccommand')
    set inccommand=split
endif
" set winwidth=100
set noemoji
" set re=0 " see https://github.com/HerringtonDarkholme/yats.vim#config
let mapleader=" "
" Permanent undo
set undodir=~/.vimdid
set undofile
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
" set background=dark
" let g:onedark_terminal_italics = 1
" let g:onedark_hide_endofbuffer = 1
" colorscheme onedark
" let g:gruvbox_bold = 0
" let g:gruvbox_italic = 1
" let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
colorscheme gruvbox
" colorscheme nord
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

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }
" let g:fzf_layout = { 'down': '~40%' }
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
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
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

" Nvim lua lsp {{{
lua require("lsp")

call sign_define("LspDiagnosticsErrorSign", {"text" : "->", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "->", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "->", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "->", "texthl" : "LspDiagnosticsHint"})

let g:diagnostic_enable_underline = 0
" let g:completion_auto_change_source = 1
" let g:completion_enable_auto_paren = 0
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
" let g:completion_matching_ignore_case = 0
" let g:completion_sorting = 'none'
" let g:completion_enable_snippet = 'vim-vsnip'
let g:vsnip_snippet_dir = expand('$HOME/.config/nvim/vsnip')
"
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

inoremap <silent><expr> <Tab>     pumvisible() ? '<C-n>' : '<Tab>'
inoremap <silent><expr> <S-Tab>   pumvisible() ? '<C-p>' : '<S-Tab>'
inoremap <silent><expr> <CR>      pumvisible() ? '<C-y>' : '<CR>'
inoremap <silent><expr> <C-Space> '<C-x><C-o>'
" inoremap <silent><expr> <c-space> completion#trigger_completion()


" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> ]g    <cmd>NextDiagnosticCycle<CR>
" nnoremap <silent> [g    <cmd>PrevDiagnosticCycle<CR>
" }}}
