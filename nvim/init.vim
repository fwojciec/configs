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
Plug 'gruvbox-community/gruvbox'
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'arcticicestudio/nord-vim'
" Plug 'joshdick/onedark.vim'

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

" quality of life
Plug 'AndrewRadev/splitjoin.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-rooter'
"
" completion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Custom
Plug 'fwojciec/vim-go-motion'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'blueyed/smarty.vim'

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
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
colorscheme gruvbox
" }}}

" FileType AutoCommands {{{
augroup AutoCommands
    autocmd!
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
            \ 'coc-go',
            \ 'coc-diagnostic',
            \ 'coc-xml',
            \ 'coc-yaml',
            \ 'coc-vimlsp',
            \ ]
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
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

" Highlight symbol under cursor on CursorHold
augroup CocNvim
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

let g:coc_status_error_sign='E'
let g:coc_status_warning_sign='W'
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

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_layout = { 'down': '~40%' }
" }}}

" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'cocstatus', 'currentfunction', 'filename' ] ]
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
let g:go_highlight_trailing_whitespace_error = 0
let g:go_def_mapping_enabled = 0
augroup GoAutoCommands
    autocmd!
    autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
    autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
    autocmd FileType go nmap gtd :CocCommand go.tags.add datastore<cr>
    autocmd FileType go nmap gtx :CocCommand go.tags.add xml<cr>
    autocmd FileType go nmap gtc :CocCommand go.tags.clear<cr>
    " autocmd BufWritePre *.go :silent call CocAction('organizeImport')
    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup end
" }}}

" Python {{{
" let g:python_highlight_all = 1
let g:python_highlight_string_templates = 1
let g:python_highlight_string_format = 1
" }}}

" Terminal {{{
augroup TerminalStuff
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber winwidth&
augroup end
" }}}

" {{{ vim-highlightedyank
let g:highlightedyank_highlight_duration = 100
" }}}

" vim test {{{
let test#strategy = 'neovim'
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

" Project-rename the current word
nnoremap <leader>prn :CocSearch <C-R>=expand('<cword>')<CR><CR>

augroup FileTypeMappings
    autocmd!
    autocmd FileType python nnoremap <buffer><silent><leader>si :CocCommand python.sortImports<CR>
augroup end

"coc-fzf
nnoremap <silent><space>c :<C-u>CocFzfList commands<CR>
nnoremap <silent><space>a :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent><space>o :<C-u>CocFzfList outline<CR>
nnoremap <silent><space>l :<C-u>CocFzfList<CR>

" terminal
" tnoremap <Esc> <C-\><C-n>
nmap <silent><leader>` :belowright 15split term://zsh \|:startinsert<CR>
" }}}
