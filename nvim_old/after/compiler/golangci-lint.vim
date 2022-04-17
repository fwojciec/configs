if exists("current_compiler")
  finish
endif
let current_compiler = "golangci-lint"

let s:cpo_save = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet errorformat&
CompilerSet makeprg=golangci-lint\ run\ --out-format\ tab\ --config\ ~/.golangci.yml

let &cpo = s:cpo_save
unlet s:cpo_save
