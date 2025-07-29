if !exists("main_syntax")
	if exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'stplc'
elseif exists("b:current_syntax") && b:current_syntax == "stplc"
	finish
endif

syntax clear

"----------------SYMBOL-MATCHING------------------
" constants
syn case  match
"syn match stplcConstant /\([a-z]\)\@<![A-Z_]\+\([a-z]\)\@!\([ ;\n)\]]\)\@=/
syn match stplcConstant /\<[A-Z_][[:alnum:]_]\+\>/

" keywords
syn case ignore
syn keyword stplckeyword do then to of constant

" variable types
syn case    ignore
syn keyword stplcType      string bool byte sint usint uint int dint udint lint ulint real lreal f_trig r_trig
syn keyword stplcPointer   pointer
syn keyword stplcReference reference
syn keyword stplcArray     array

" block identifiers
syn case  match
"TODO: Does not match test : __SYSTEM.VAR_INFO;
syn match stplcDefinition     /\v:\s*\zs[[:alnum:]\._]+\ze[:;\(]$/
syn match stplcFunctionBlock /\(\s*\)\@<=FB_[A-Za-z]*\([; \n).\])(]\)\@=/
syn match stplcStruct        /\(\s*\)\@<=ST_[A-Za-z]*\([; \n).\])]\)\@=/
syn match stplcEnumeration   /\(\s*\)\@<=E_[A-Za-z]*\([; \n).\])]\)\@=/
syn match stplcFunction      /\(\s*\)\@<=F_[A-Za-z]*\([; \n).\]()]\)\@=/
syn match stplcGlobalVarList /\(\s*\)\@<=GVL_[A-Za-z]*\([; \n).\])]\)\@=/
"syn match stplcMethod /\s*\.\zs[[:alnum:]]+\ze(/
syn match stplcMethod /\v\s*\zs_*[[:alnum:]]+\ze\(/

" control statements
syn case    ignore
syn keyword stplcConditional if else then elsif end_if case end_case
syn keyword stplcLoop        while end_while for end_for 
syn keyword stplcStatement   struct end_struct type end_type function_block end_function_block var end_var var_input var_output var_in_out var_config program end_program method var_global
syn keyword stplcFunction return exit

" operators
syn case    ignore
syn match stplcOperator /[\+\-:=<>;\^\[\]()/\*\.]/

" values
syn case    match
syn match   stplcString  /\(".*"\)\|\('.*'\)/
syn keyword stplcBoolean true false TRUE FALSE
"syn match stplcNumber /\%(^\|\s\|\.\)\zs-\?\d\+\ze\%($\|\s\|;\|\.\|]\)/
syn match stplcNumber /\v(\(|^|\s|\.|\[|([^[:alnum:]_]))@<=-?\d+(\)|$|\s|;|\.|,|])@=/

syn match stplcXML      /<.*>/
syn match stplcCDATA    /<!\[CDATA\[/
syn match stplcCDATAEnd /\]\]>/
"syn region stplcXML start=/</ skip=/CDATA\[.*\]/ end=/>/

" tgawe 1 
" comments
syn case  match
syn match stplcCommentTodo /\v<(TODO|FIXME|NOTE|BUG):?/ containedin=ALL
syn region stplcCommentMultiLine start=/(\*/ skip=/TODO/ end=/\*)/
syn match stplcCommentSingleLine /\/\/.*$/
syn match stplcCommentImportant  /\/\/!.*$/
syn match stplcCommentQuestion   /\/\/?.*$/
syn match stplcCommentDocKeyword /\v<(DESCRIPTION|AUTHOR|Status):?/ containedin=ALL

" pragmas
syn case  ignore
syn match stplcPragma /{.*}/

"----------------SYMBOL-LINKING-------------------
hi def link stplcXML      LineNr
hi def link stplcCDATA    LineNr
hi def link stplcCDATAEnd LineNr

" keywords
hi def link stplcPointer   stplcKeyword
hi def link stplcReference stplcKeyword
hi def link stplcKeyword   Keyword

" values
hi def link stplcBoolean Boolean
hi def link stplcString  String
hi def link stplcNumber  Number

" comments
hi def link stplcCommentSingleLine Comment
hi def link stplcCommentMultiLine  Comment
"hi def link stplcDocCommentMultiLine  Comment
"hi def link stplcDocCommentSingleLine Comment
hi def link stplcCommentImportant  DiagnosticWarn
hi def link stplcCommentQuestion   MoreMsg
hi def link stplcCommentTodo       Todo
highlight MyUnderlined guifg=#909bb0 gui=underline
hi def link stplcCommentDocKeyword MyUnderlined

" pragmas
hi def link stplcPragma  Macro

" control flow
hi def link stplcConditional Conditional
hi def link stplcLoop        Repeat

" variable types
hi def link stplcArray         stplcType
hi def link stplcPointer       stplcType
hi def link stplcEnumeration   stplcType
hi def link stplcFunctionBlock stplcType
hi def link stplcStruct        stplcType
hi def link stplcDefinition    stplcType
hi def link stplcType          Type

hi def link stplcGlobalVarList @namespace

" functions
hi def link stplcFunction  Function
hi def link stplcMethod    Function

" statements
hi def link stplcStatement Statement

" operators
hi def link stplcOperator Operator

" constants
hi def link stplcConstant Constant

let b:current_syntax = "stplc"
