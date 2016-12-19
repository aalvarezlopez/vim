" Vim syntax file
" Language:	Pclint
" Maintainer:	Neil Schemenauer <nas@pclint.ca>
" Last Change:	2013 Feb 26
" Credits:	Zvezdan Petkovic <zpetkovic@acm.org>
"		Neil Schemenauer <nas@pclint.ca>
"		Dmitry Vasiliev
"
"		This version is a major rewrite by Zvezdan Petkovic.
"
"		- introduced highlighting of doctests
"		- updated keywords, built-ins, and exceptions
"		- corrected regular expressions for
"
"		  * functions
"		  * decorators
"		  * strings
"		  * escapes
"		  * numbers
"		  * space error
"
"		- corrected synchronization
"		- more highlighting is ON by default, except
"		- space error highlighting is OFF by default
"
" Optional highlighting can be controlled using these variables.
"
"   let pclint_no_builtin_highlight = 1
"   let pclint_no_doctest_code_highlight = 1
"   let pclint_no_doctest_highlight = 1
"   let pclint_no_exception_highlight = 1
"   let pclint_no_number_highlight = 1
"   let pclint_space_error_highlight = 1
"
" All the options above can be switched on together.
"
"   let pclint_highlight_all = 1
"

" For version 5.x: Clear all syntax items.
" For version 6.x: Quit when a syntax file was already loaded.
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword pclintNote Note nextgroup=pclintcodeNumber skipwhite
syn keyword pclintInfo Info nextgroup=pclintcodeNumber skipwhite
syn keyword pclintWarning Warning nextgroup=codeNumber skipwhite

let b:current_syntax = "pclint"

hi Note ctermfg=20 ctermbg=160 cterm=bold
hi Error ctermfg=60 ctermbg=30 cterm=bold
hi Info ctermfg=20 ctermbg=72 cterm=bold

hi! def link pclintNote        Note
hi! def link pclintWarning     Error
hi! def link pclintInfo        Info
