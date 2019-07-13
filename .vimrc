call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Color schemes and interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'

" CtrlP
Plug 'kien/ctrlp.vim'

" Linting
Plug 'w0rp/ale'

" Go Support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" LSP support
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

" configuration
" let mapleader=","
set number
set relativenumber
set clipboard=unnamed
set hidden
set cmdheight=2
set updatetime=300
set signcolumn=yes
set autowrite " helpful for vim-go so you can build/run without saving beforhand

" Make search case insensitive
set hlsearch
set ignorecase
set smartcase

" Disable backup and swap files -- they trigger too many events for file
" system watchers
set nobackup
set nowritebackup
set noswapfile

" Splits
set splitbelow
set splitright

filetype plugin indent on
syntax on

" visual
set t_Co=256
set background=dark
" if (has("termguicolors"))
" 	set termguicolors
" endif
if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

colorscheme OceanicNext

" Send more characters for redraws
set ttyfast
" Enable the mouse in all modes
set mouse=a

" move line up and down with indentation
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Reindent the entire file
nmap <leader>= mzgg=G`z

" vim-go mappings and configuration
" map <C-n> :cnext<CR>
" map <C-m> :cprevious<CR>
" nnoremap <leader>a :cclose<CR>
" let g:go_list_type = "quickfix"
" let g:go_fmt_command = "goimports"
" " let g:go_highlight_types = 1
" " let g:go_highlight_functions = 1
" " let g:go_highlight_function_calls = 1
" " let g:go_highlight_extra_types = 1
" let g:go_term_height = 10
" let g:go_term_width = 30
" let g:go_term_mode = "split"
" let g:go_auto_type_info = 1
" let g:go_term_enabled = 1
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'
let g:go_metalinter_enabled = 0
let g:go_def_mapping_enabled = 0 " coc.nvim takes care of that now
let g:go_fmt_fail_silently = 1 " prevents opening location list on lint errors

" fun :GoBuild or :GoTestCompile based on the go file
" function! s:build_go_files()
" 	let l:file = expand('%')
" 	if l:file =~# '^\f\+_test\.go$'
" 		call go#test#Test(0, 1)
" 	elseif l:file =~# '^\f\+\.go$'
" 		call go#cmd#Build(0)
" 	endif
" endfunction

" AutoCommands
augroup AutoCommands
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
	autocmd BufNewFile,BufRead *.html setlocal noexpandtab tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4
	autocmd BufNewFile,BufRead *.json setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.toml setlocal tabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.vim setlocal tabstop=4 shiftwidth=4
	" autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
	" autocmd FileType go nmap <leader>b  <Plug>(go-build)
	" autocmd FileType go nmap <leader>r  <Plug>(go-run)
	" autocmd FileType go nmap <leader>t  <Plug>(go-test)
	" autocmd FileType go nmap <leader>c  <Plug>(go-coverage-toggle)
	" autocmd FileType go nmap <Leader>i  <Plug>(go-info)
	" autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
	" autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
	" autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
	" autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" Settings for vim-airline
let g:airline_powerline_fonts = 0

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
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
" let g:ctrlp_use_caching = 0

" " deoplete configuration
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
" let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" set completeopt-=preview
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" ale configuration
let g:ale_fixers = {'go': ['goimports']}
let g:ale_linters = {'go': ['golint', 'gopls', 'govet']}
let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 0
let g:ale_open_list = 0


" coc.nvim settings
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

" inoremap <silent><expr> <Tab>
" 			\ pumvisible() ? "\<C-n>" :
" 			\ <SID>check_back_space() ? "\<Tab>" :
" 			\ coc#refresh()

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
