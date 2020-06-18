" Plugins {{{
let g:plug_shallow = 0

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-python/python-syntax'
Plug 'vim-scripts/indentpython.vim'
Plug 'ycm-core/YouCompleteMe', { 'branch': 'legacy-py2', 'do': 'git submodule update --init --recursive && ./install.py --go-completer --rust-completer --ts-completer' }
call plug#end()
" }}}

" General settings {{{
set number
set relativenumber
set clipboard=unnamed
set hidden
set nobackup
set nowritebackup
set cmdheight=2
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
let mapleader= " "

syntax on
filetype plugin indent on
" }}}

" Colorscheme {{{
set termguicolors
set background=dark
colorscheme nord
" }}}

" FileType AutoCommands {{{
augroup AutoCommands
	autocmd BufNewFile,BufRead *.html setlocal noexpandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.json setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.js setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.jsx setlocal expandtab tabstop=2 shiftwidth=2 filetype=javascript.tsx
	autocmd BufNewFile,BufRead *.ts setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.tsx setlocal expandtab tabstop=2 shiftwidth=2 filetype=typescript.tsx
	autocmd BufNewFile,BufRead *.yam setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.toml setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.hs setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.hsc setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.lhs setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.cabal setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.scala setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.sbt setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.vim setlocal expandtab tabstop=4 shiftwidth=4 foldmethod=marker
augroup end
" }}}

" YouCompleteMe {{{
nmap <silent> <leader>d :YcmCompleter GoToDefinition<CR>
nmap <silent> gy :YcmCompleter GetType<CR>
nmap <silent> gr :YcmCompleter GoToReferences<CR>
let g:ycm_autoclose_preview_window_after_completion=1

" }}}

" FZF settings {{{
function! s:fzf_statusline()
	" Nord colors
	" highlight fzf1 ctermfg=1 ctermbg=0 guifg=#BF616A guibg=#3B4252
	" highlight fzf2 ctermfg=4 ctermbg=0 guifg=#81A1C1 guibg=#3B4252
	" highlight fzf3 ctermfg=14 ctermbg=0 guifg=#8FBCBB guibg=#3B4252

	" GruvBox colors
	highlight fzf1 ctermfg=1 ctermbg=0 guifg=#fb4934 guibg=#3c3836
	highlight fzf2 ctermfg=4 ctermbg=0 guifg=#fe8019 guibg=#3c3836
	highlight fzf3 ctermfg=14 ctermbg=0 guifg=#fe8019 guibg=#3c3836
	setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()
" }}}

" Mappings {{{
" FZF mappings
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader><CR>     :Buffers<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>ag       :Ag! <C-R><C-W><CR>
nnoremap <leader>gf       :GoDecls <CR>
nnoremap <leader>gd       :GoDeclsDir <CR>
" }}}

" Mappings {{{
" FZF mappings
nnoremap <leader><leader> :GitFiles<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader><CR>     :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>ag       :Ag<CR>
" }}}

" Airline {{{
let g:airline_powerline_fonts = 1
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" let g:airline_symbols.notexists = '❔'
" let g:airline_symbols.dirty= '❕'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = ''
" }}}

" Python {{{
" let g:python_highlight_all = 1
let g:python_highlight_string_templates = 1
let g:python_highlight_string_format = 1
" }}}

" Mappings {{{
" Move around splits with <c-hjkl>
" nnoremap <C-j> <c-w>j
" nnoremap <C-k> <c-w>k
" nnoremap <C-h> <c-w>h
" nnoremap <C-l> <c-w>l
" }}}
