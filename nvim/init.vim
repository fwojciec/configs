" Plugins {{{
call plug#begin()
" tpope is a separate category
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'

" interface
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/vim-slash'
Plug 'arcticicestudio/nord-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'mengelbrecht/lightline-bufferline'

" filesystem
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'airblade/vim-rooter'

" completion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neovim/nvim-lsp'

" language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'cousine/go-present-slide-syntax.vim'
Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'vim-python/python-syntax'
Plug 'vim-scripts/indentpython.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'blueyed/smarty.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'lifepillar/pgsql.vim'
Plug 'cespare/vim-toml'
Plug 'uarun/vim-protobuf'
call plug#end()
" }}}

" General settings {{{
" I assume the vim-sensible plugin is present
set number
set relativenumber
set cursorline
set clipboard=unnamed
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
set hlsearch
set ignorecase
set smartcase
set mouse=a
set noshowmode
set tabstop=4
set shiftwidth=4
set expandtab
set showtabline=2
" set winwidth=100
set noemoji
set re=0 " see https://github.com/HerringtonDarkholme/yats.vim#config
let mapleader=" "
" Permanent undo
set undodir=~/.vimdid
set undofile

if filereadable('/Users/filip/.pyenv/versions/3.8.5/bin/python')
    " Avoid search, speeding up start-up.
    let g:python3_host_prog='/Users/filip/.pyenv/versions/3.8.5/bin/python'
endif
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
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
colorscheme gruvbox
" }}}

" FileType AutoCommands {{{
augroup AutoCommands
    autocmd BufWritePost init.vim nested so $MYVIMRC
    autocmd FileType go setlocal noexpandtab tabstop=8 shiftwidth=8
    autocmd FileType html setlocal tabstop=2 shiftwidth=2
    autocmd FileType json setlocal tabstop=2 shiftwidth=2
    autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
    autocmd FileType toml setlocal tabstop=2 shiftwidth=2
    autocmd FileType css setlocal tabstop=2 shiftwidth=2
    autocmd FileType scss setlocal tabstop=2 shiftwidth=2
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 autoindent
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

" Coc Settings {{{
let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-eslint',
            \ 'coc-tsserver',
            \ 'coc-emmet',
            \ 'coc-css',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-prettier',
            \ 'coc-python',
            \ 'coc-elixir'
            \ ]

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_status_error_sign='E'
let g:coc_status_warning_sign='W'
" }}}

" vim-go configuration {{{
" let g:go_metalinter_autosave = 1 
let g:go_metalinter_enabled = ['vet', 'golint']
let g:go_highlight_diagnostic_errors = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_echo_go_info = 0
let g:go_template_autocreate=0
" }}}

" vim-haskell settings {{{
let g:haskell_indent_before_where = 1
let g:haskell_indent_after_bare_where = 1
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

" remove status line from terminal buffer containing fzf
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}}

" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'cocstatus' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'fugitive': 'FugitiveHead',
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_raw': { 'buffers': 1 }
      \ }

      " \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      " \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
let g:lightline#bufferline#clickable = 1
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
" }}}

" Python {{{
" let g:python_highlight_all = 1
let g:python_highlight_string_templates = 1
let g:python_highlight_string_format = 1
" }}}

" Terminal {{{
augroup TerminalStuff
    au!
    autocmd TermOpen * setlocal nonumber norelativenumber winwidth&
augroup end
" }}}

" VimRooter {{{
let g:rooter_silent_chdir = 1
" }}}

" Mappings {{{
nnoremap <silent><leader><leader> :GitFiles<CR>
nnoremap <silent><leader><CR>     :Buffers<CR>
nnoremap <silent><leader>fi       :Files<CR>
nnoremap <silent><leader>fl       :Lines<CR>
nnoremap <silent><leader>ag       :Ag<CR>
" nnoremap <leader>gf       :GoDecls <CR>
" nnoremap <leader>gd       :GoDeclsDir <CR>

" better paste
vnoremap p "_dP

" don't use arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>prn :CocSearch <C-R>=expand('<cword>')<CR><CR>

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup FileTypeMappings
    autocmd FileType python nnoremap <buffer><silent><leader>si :CocCommand python.sortImports<CR>
    autocmd FileType go nnoremap <buffer><silent><leader>l :GoMetaLinter<CR>
augroup end
" }}}
