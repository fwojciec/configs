" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')
" tpope is a separate category
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-dispatch'

" interface
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'gruvbox-community/gruvbox'
" Plug 'srcery-colors/srcery-vim'
" Plug 'haishanh/night-owl.vim'
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'arcticicestudio/nord-vim'
" Plug 'joshdick/onedark.vim'
" Plug 'chriskempson/base16-vim'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sainnhe/gruvbox-material'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" quality of life
Plug 'AndrewRadev/splitjoin.vim'
Plug 'dhruvasagar/vim-table-mode'
" Plug 'airblade/vim-rooter'
" Plug 'junegunn/vim-slash'

" completion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Syntax
Plug 'sheerun/vim-polyglot'

" Testing
Plug 'vim-test/vim-test'

" language support
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
set shortmess+=cI
set signcolumn=number " no need for gutter to display diagnostics info
set mouse=a
set noemoji
set updatetime=50
set clipboard+=unnamedplus
set nofixendofline
set title
set formatoptions-=t " prevents automatic wrapping
" set textwidth=80
if exists('&inccommand')
    set inccommand=split
endif
" }}}

" Fast startup {{{
let g:python3_host_prog = '/Users/filip/.pyenv/versions/neovim/bin/python'
" let g:python_host_prog = expand("$HOME").'/.pyenv/shims/python2'
" let g:ruby_host_prog = expand("$HOME").'/.gem/ruby/2.6.0/bin/neovim-ruby-host'
let g:node_host_prog = expand("$HOME").'/.nvm/versions/node/v14.17.6/bin/neovim-node-host'
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
" }}}

" Colorscheme {{{
if (has("termguicolors"))
    " set Vim-specific sequences for RGB colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
" set background=light
" let g:onedark_terminal_italics = 1
" let g:onedark_hide_endofbuffer = 1
" colorscheme onedark
" let g:gruvbox_italic = 1
" let g:gruvbox_underline = 0
" let g:gruvbox_bold = 0
" let g:gruvbox_invert_selection = 0
" let g:gruvbox_contrast_dark = 'hard'
" colorscheme gruvbox
" let g:dracula_italic = 0
" colorscheme dracula
" let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material
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
    autocmd FileType lua setlocal tabstop=2 shiftwidth=2
    autocmd FileType markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2 autoindent
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 autoindent
    autocmd FileType python let b:indentLine_enabled=1
    autocmd FileType vim setlocal tabstop=4 shiftwidth=4 foldmethod=marker
    " autocmd FileType scss setl iskeyword+=@-@
    autocmd FileType yaml let b:indentLine_enabled=1
    " enable comments in json files
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd BufNewFile,BufRead *.hs setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.hsc setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.lhs setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.cabal setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.scala setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.sbt setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.pgsql setlocal tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.js setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.tsx setlocal tabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead requirements*.txt setlocal filetype=requirements
    autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
    autocmd BufNewFile,BufRead .prettierrc setlocal filetype=json

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

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let g:fzf_layout = { 'down': '~40%' }
" }}}

" Lightline {{{
let g:lightline = {
            \ 'colorscheme': 'gruvbox_material',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'cocstatus', 'readonly', 'relativepath', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status',
            \   'currentfunction': 'CocCurrentFunction',
            \   'fugitive': 'FugitiveHead',
            \ }
            \ }
augroup Lightline
    autocmd!
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup end
" }}}

" Go {{{
let g:go_highlight_trailing_whitespace_error=0
let g:go_highlight_string_spellcheck=1
let g:go_highlight_format_strings=1
let g:go_highlight_generate_tags=1

augroup GoAutoCommands
    autocmd!
    autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
    autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
    autocmd FileType go nmap gtd :CocCommand go.tags.add datastore<cr>
    autocmd FileType go nmap gtx :CocCommand go.tags.add xml<cr>
    autocmd FileType go nmap gtc :CocCommand go.tags.clear<cr>
    autocmd FileType go nmap <leader>m :silent !go generate ./mocks/... <CR>\|:silent CocRestart<CR>
    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup end
" }}}

" Rust {{{
augroup RustAutoCommands
    autocmd!
    autocmd FileType rust nmap gh :CocCommand rust-analyzer.toggleInlayHints<cr>
augroup end
" }}}

" Python {{{
" let g:python_highlight_all = 1
let g:python_highlight_string_templates = 1
let g:python_highlight_string_format = 1
let g:python_highlight_space_errors = 0

augroup PythonAutocommands
    autocmd!
    autocmd FileType python nnoremap <buffer><silent><leader>si :CocCommand python.sortImports<CR>
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
augroup end
" }}}

" vim test {{{
let test#strategy = 'neovim'
" let test#neovim#term_position = "botright 15"
" }}}

" Terraform {{{
let g:terraform_align=1
let g:terraform_fmt_on_save=1
" }}}

" Mappings {{{
let mapleader=' '

" fzf
nnoremap <silent><leader><leader> :GitFiles<CR>
nnoremap <silent><leader><CR>     :Buffers<CR>
nnoremap <silent><leader>fi       :Files<CR>
nnoremap <silent><leader>fl       :Lines<CR>
nnoremap <silent><leader>ag       :Ag<CR>

" coc
nnoremap <silent><leader>rr       :silent CocRestart<CR>

" better paste
vnoremap p "_dP
" Y yanks from the cursor to the end of line as expected
nnoremap Y y$
" Visually select the text that was last edited/pasted (Vimcast#26).
noremap gV `[v`]

" don't use arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Project-rename the current word
nnoremap <leader>prn :CocSearch <C-R>=expand('<cword>')<CR><CR>

" vim test
nmap <silent> <leader>t  :TestNearest<CR>
nmap <silent> <leader>T  :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" terminal
" tnoremap <Esc> <C-\><C-n>
nmap <silent><leader>` :belowright 15split term://zsh \|:startinsert<CR>

" no more :W
nnoremap ; :
" }}}

"{{{IndentLine
let g:indentLine_enabled = 0
let g:indentLine_char = '⦙'
"}}}

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
            \ 'coc-pyright',
            \ 'coc-go',
            \ 'coc-xml',
            \ 'coc-yaml',
            \ 'coc-vimlsp',
            \ 'coc-toml',
            \ ]

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references-used)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup CocAutocommands
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ga  <Plug>(coc-codeaction-selected)
nmap <leader>ga  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>gca  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>gqf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

let g:coc_status_error_sign='E'
let g:coc_status_warning_sign='W'
" }}}

" {{{treesitter
" https://github.com/nvim-treesitter/nvim-treesitter#available-modules
lua require("treesitter")
" tree-sitter reparse
nmap <leader>we :write \| edit \| TSBufEnable highlight<CR>
" }}}
