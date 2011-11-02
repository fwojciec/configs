" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:


" forward searching dvi files
let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'latexmk -silent -pdf $*'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf = 'acroread'
