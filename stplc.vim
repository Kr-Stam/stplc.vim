if !exists("main_syntax")
	if exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'stplc'
elseif exists("b:current_syntax") && b:current_syntax == "stplc"
	finish
endif

"----------------SYMBOL-MATCHING------------------

" constants
syn case  match
syn match stplcConstant /\([ \t(]*\)\@<=[A-Z_]\+\([a-z]\)\@!\([ ;\n)]\)\@=/

" keywords
syn case ignore
syn keyword stplckeyword do then to of constant

" variable types
syn case    ignore
syn keyword stplcType      string bool byte sint usint uint int dint udint lint ulint real lreal f_trig r_trig
syn keyword stplcPointer   pointer
syn keyword stplcReference reference
syn keyword stplcArray     array

" standard functions
syn case    ignore
syn keyword stplcSizeOf sizeof
syn keyword stplcMalloc __new __delete
" TODO: need to add all conversion functions

" block identifiers
syn case  match
syn match stplcFunctionBlock /\(\s*\)\@<=FB_[A-Za-z]*\([; \n]\)\@=/
syn match stplcStruct        /\(\s*\)\@<=ST_[A-Za-z]*\([; \n]\)\@=/
syn match stplcEnumeration   /\(\s*\)\@<=E_[A-Za-z]*\([; \n]\)\@=/
syn match stplcFunction      /\(\s*\)\@<=F_[A-Za-z]*\([; \n]\)\@=/

" TODO: Finish this when I am not lazy
" variable names
"syn case  match
"syn match stplcVariablefb /\(\s\|^\|(\)\@<=FB_[A-Za-z]*\([; \n]\)\@=/
"syn match stplcVariablen  /\(\s*\)\@<=FB_[A-Za-z]*\([; \n]\)\@=/
"syn match stplcVariablel        /\(\s*\)\@<=ST_[A-Za-z]*\([; \n]\)\@=/
"syn match stplcVariabler   /\(\s*\)\@<=E_[A-Za-z]*\([; \n]\)\@=/
"syn match stplcVariableFunction      /\(\s*\)\@<=F_[A-Za-z]*\([; \n]\)\@=/

" control statements
syn case    ignore
syn keyword stplcConditional if else then elsif end_if case end_case
syn keyword stplcLoop        while end_while for end_for 
syn keyword stplcStatement   struct end_struct type end_type function_block end_function_block var end_var var_input var_output var_in_out var_config program end_program method var_global
syn keyword stplcFunction return exit

" operators
syn case    ignore
syn match stplcOperator /[+-:=<>;]/

" values
syn case    match
syn match   stplcString  /\(".*"\)\|\('.*'\)/
syn keyword stplcBoolean true false
syn match   stplcNumber  /\([a-zA-Z]\)\@<!\(\s\|^\)-\?\d\+/

" tgawe 1 
" comments
syn case  ignore
syn match stplcCommentMultiLine     /\(\*\*\_.*.*\*\*\)/
syn match stplcCommentSingleLine    /\/\/.*$/
syn match stplcDocCommentMultiLine  /\(\*\*\*\_.*.*\*\*\*\)/
syn match stplcDocCommentSingleLine /\/\/\/.*$/
"syn match stplcCommentImportant     /\/\/!.*$/
"syn match stplcCommentQuestion      /\/\/?.*$/

" pragmas
syn case  ignore
syn match stplcPragma /{.*}/

"----------------SYMBOL-LINKING-------------------

" keywords
hi def link stplcPointer   stplcKeyword
hi def link stplcReference stplcKeyword
hi def link stplcArray     stplcKeyword
hi def link stplcKeyword   Keyword

" values
hi def link stplcBoolean Boolean
hi def link stplcString  String
hi def link stplcNumber  Number

" comments
hi def link stplcCommentSingleLine Comment
hi def link stplcCommentMultiLine  Comment
hi def link stplcDocCommentMultiLine  Comment
hi def link stplcDocCommentSingleLine Comment

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
hi def link stplcType          Type

" functions
hi def link stplcSizeOf    stplcFunction
hi def link stplcMalloc    stplcFunction
hi def link stplcFunction  Function

" statements
hi def link stplcStatement Statement

" operators
hi def link stplcOperator Operator

" constants
hi def link stplcConstant Constant

let b:current_syntax = "stplc"
