" Inspired by https://www.youtube.com/watch?v=YhqsjUUHj6g

" Disable some mappings to learn vim
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Keyboard movement
noremap <Char-0x05> $
noremap <Char-0x01> ^
inoremap <Char-0x05> <C-o>$
inoremap <Char-0x01> <C-o>^
noremap <D-Up> <C-f>
noremap <D-Down> <C-b>

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy and paste
set pastetoggle=<F2>
set clipboard=unnamed

" Mouse and backspace
set mouse=a	" on OSX press ALT and click
set bs=2	" make backspace behave like normal again

" Rebind <Leader> key
" Map it to space rather than comma, bacause comma is useful for movement
let mapleader = " "

" Bind Ctrl+<movement> keys to move around the windows instead of using Ctrl+w + <movement>
" map <c-j> <c-w>j
" map <c-k> <c-w>k
" map <c-l> <c-w>l
" map <c-h> <c-w>h

" Easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Map sort function to a key
"vnoremap <Leader>s :sort<CR>

" Easier moving of code blocks
vnoremap < <gv	" better indentation
vnoremap > >gv	" better indentation

" Show whitespace
" Must be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" gvim font
"set guifont=Envy\ Code\ R:h14
set guifont=Monaco\ for\ Powerline:h14
" set guifont=Hack:h13
" set guifont=Cousine\ for\ Powerline:h13

" Set guioptions
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
let python_highlight_all=1
syntax on

" Showing line numbers and length
set relativenumber
set number 	" show line numbers
set tw=99	" width of document (used by gd)
set nowrap 	" don't automatically wrap on load
set fo-=t	" don't automatically wrap tex when typing
set colorcolumn=100
highlight ColorColumn ctermbg=233

" Easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent
set fileformat=unix

" Use different settings for html, css and django templates
autocmd Filetype html,htmldjango,css,scss setlocal ts=2 sts=2 sw=2 | EmmetInstall
autocmd Filetype javascript,javascript.jsx setlocal ts=2 sts=2 sw=2

" Use a different comment style for Django's HTML templates.
autocmd FileType htmldjango set commentstring={#\ %s\ #}

" Use different settings for html, css and django templates
autocmd Filetype python,python.django setlocal ts=4 sts=4 sw=4
autocmd FileType python,python.django set colorcolumn=100

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable backup and swap files -- they trigger too many events for file
" system watchers
set nobackup
set nowritebackup
set noswapfile

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()

" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2

" Settings for vim-airline
let g:airline_powerline_fonts = 1

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

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
" set nofoldenable

" Emmet Vim configs
let g:user_emmet_install_global = 0
autocmd FileType html,htmldjango,css,scss EmmetInstall
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_leader_key='<C-e>'

" NREDTree configuration
map <C-n> :NERDTreeToggle<CR>
" If nerdtree is the only window open close vim
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" YouCompleteMe settings
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
set completeopt=menu "prevents opening of docs menu

" Disable bell in gvim/macvim
autocmd! GUIEnter * set vb t_vb=

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
set background=dark

if has('gui_running')
    set background=dark
    colorscheme solarized
    highlight SignColumn guibg=bg
    " if &background ==# "light"
    "     highlight SignColumn guibg=#eee7d4
    " else
    "     highlight SignColumn guibg=#013944
    " endif
else
    set background=dark
    colorscheme solarized
    " colorscheme NeoSolarized
    colorscheme solarized
    " colorscheme wombat256mod
endif

" Pylint configuration file
let g:pymode_lint_config = '$HOME/.pylint.rc'
let g:pymode_options_max_line_length=100

" Disable automatic folding
set nofoldenable

"Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=3
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['eslint']


" "Ale settings
" let g:ale_sign_column_always = 1
" let g:airline#extensions#ale#enabled = 1
" " highlight SignColumn guibg=bg
" let g:ale_completion_enabled = 0

"Javascript settings
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 1

" Autopep8 settings
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
let g:autopep8_max_line_length=100
let g:autopep8_disable_show_diff=1
