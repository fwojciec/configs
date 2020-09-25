setlocal noexpandtab tabstop=8 shiftwidth=8
setlocal formatoptions-=t
setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal commentstring=//\ %s
setlocal nowrap

let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_def_mapping_enabled = 0

nmap <silent> <leader>t  :TestNearest -v -race<CR>
nmap <silent> <leader>T  :TestFile -v -race<CR>
nmap <silent> <leader>ts :TestSuite -v -race<CR>
nmap <silent> <leader>tl :TestLast -v -race<CR>
nmap <silent> <leader>tv :TestVisit<CR>
nmap <silent> <leader>l  :Dispatch golangci-lint run --config ~/.golangci.yml --out-format tab<CR>

augroup GoAutoCommands
    autocmd!
    autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup end
