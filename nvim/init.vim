" Plugins {{{
call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'sheerun/vim-polyglot'
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
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
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

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
    autocmd BufWritePost init.vim so $MYVIMRC | AirlineRefresh
    autocmd BufWritePost init.vim AirlineRefresh
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
    autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.vim setlocal expandtab tabstop=4 shiftwidth=4 foldmethod=marker
augroup end
" }}}

" Coc Settings {{{
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


" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,javascript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
    autocmd BufWritePre *.hs :call CocAction('format')
    " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html Prettier
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}}

" vim-go configuration {{{
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_metalinter_autosave=1
" }}}

" vim-haskell settings {{{
let g:haskell_indent_before_where = 1
let g:haskell_indent_after_bare_where = 1
" }}}

" FZF settings {{{
function! s:fzf_statusline()
    highlight fzf1 ctermfg=1 ctermbg=0 guifg=#BF616A guibg=#3B4252
    highlight fzf2 ctermfg=4 ctermbg=0 guifg=#81A1C1 guibg=#3B4252
    highlight fzf3 ctermfg=14 ctermbg=0 guifg=#8FBCBB guibg=#3B4252
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()
" }}}

" Mappings {{{
" FZF mappings
nnoremap <leader><leader> :GFiles<CR>
nnoremap <leader>fi       :Files<CR>
nnoremap <leader><CR>     :Buffers<CR>
nnoremap <leader>fl       :Lines<CR>
nnoremap <leader>ag       :Ag! <C-R><C-W><CR>
nnoremap <leader>gf       :GoDecls <CR>
nnoremap <leader>gd       :GoDeclsDir <CR>
vnoremap p "_dP " better paste
" }}}

" Airline {{{
let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = ''
" }}}

" DelimitMate {{{
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
" }}}

" Rust {{{
let g:rustfmt_autosave = 1
" }}}
