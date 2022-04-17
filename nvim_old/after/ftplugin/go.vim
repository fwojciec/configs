setlocal noexpandtab tabstop=4 shiftwidth=4
setlocal formatoptions-=t
setlocal nowrap

" let g:go_highlight_trailing_whitespace_error = 0
" let g:go_def_mapping_enabled = 0

nmap <silent> <leader>t  :TestNearest -race<CR>
nmap <silent> <leader>T  :TestFile -race<CR>
nmap <silent> <leader>ts :TestSuite -race<CR>
nmap <silent> <leader>tl :TestLast -race<CR>
nmap <silent> <leader>tv :TestVisit<CR>
nmap <silent> <leader>gcl  :Dispatch golangci-lint run --config ~/.golangci.yml --out-format tab<CR>
