setlocal tabstop=4 softtabstop=4 shiftwidth=4 autoindent
" setlocal formatprg=autopep8\ -

let g:python_highlight_string_templates = 1
let g:python_highlight_string_format = 1

nmap <silent> <leader>t  :TestNearest<CR>
nmap <silent> <leader>T  :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
" nmap <silent> <leader>ff gggqG

" augroup PythonAutoCommands
"     autocmd!
"     autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
" augroup end
