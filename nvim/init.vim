call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'mhartington/oceanic-next'
Plug 'arcticicestudio/nord-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'kien/ctrlp.vim'
Plug 'Shougo/echodoc.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

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

set t_Co=256
set background=dark
if (has('termguicolors'))
	set termguicolors
endif
" colorscheme gruvbox
colorscheme nord

syntax on
filetype plugin indent on

augroup AutoCommands
	autocmd BufWritePost init.vim so $MYVIMRC | call LightlineReload()
	autocmd BufNewFile,BufRead *.html setlocal noexpandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.json setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.js setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.jsx setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.ts setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.tsx setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.yam setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.toml setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.vim setlocal tabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.hs setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.hsc setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.lhs setlocal expandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.cabal setlocal expandtab tabstop=2 shiftwidth=2
augroup END

" Use tab for trigger completion with characters ahead, navigate (and snippets)
inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

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
	autocmd User CocDiagnosticChange call lightline#update()
	autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
	autocmd BufWritePre *.hs :call CocAction('format')
	autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html Prettier
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" vim-go configuration
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_metalinter_autosave=1

" vim-haskell settings
let g:haskell_indent_before_where = 1
let g:haskell_indent_after_bare_where = 1

" ctrlp
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/node_modules/*
set wildignore+=*/venv/*
set wildignore+=*.egg-info*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*/package-lock.json
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Lightline
function! LightlineReload()
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
endfunction

let g:lightline = {
			\ 'colorscheme': 'nord',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'readonly', 'filename', 'modified', 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ],
			\   'right': [ [ 'lineinfo',  ],
			\              [ 'percent' ],
			\              [ 'fileformat', 'fileencoding', 'filetype'] ]
			\ },
			\ 'component_expand': {
			\   'coc_error'        : 'LightlineCocErrors',
			\   'coc_warning'      : 'LightlineCocWarnings',
			\   'coc_info'         : 'LightlineCocInfos',
			\   'coc_hint'         : 'LightlineCocHints',
			\   'coc_fix'          : 'LightlineCocFixes',
			\ },
			\ }

let g:lightline.component_type = {
			\   'coc_error'        : 'error',
			\   'coc_warning'      : 'warning',
			\   'coc_info'         : 'tabsel',
			\   'coc_hint'         : 'middle',
			\   'coc_fix'          : 'middle',
			\ }

function! s:lightline_coc_diagnostic(kind, sign) abort
	let info = get(b:, 'coc_diagnostic_info', 0)
	if empty(info) || get(info, a:kind, 0) == 0
		return ''
	endif
	try
		let s = g:coc_user_config['diagnostic'][a:sign . 'Sign']
	catch
		let s = ''
	endtry
	return printf('%s %d', s, info[a:kind])
endfunction

function! LightlineCocErrors() abort
	return s:lightline_coc_diagnostic('error', 'error')
endfunction

function! LightlineCocWarnings() abort
	return s:lightline_coc_diagnostic('warning', 'warning')
endfunction

function! LightlineCocInfos() abort
	return s:lightline_coc_diagnostic('information', 'info')
endfunction

function! LightlineCocHints() abort
	return s:lightline_coc_diagnostic('hints', 'hint')
endfunction

" Echodoc
let g:echodoc_enable_at_startup = 1
