if expand('%:e') =~ 'Tc'
	if !exists("main_syntax") 
		if exists("b:current_syntax")
			finish
		endif
		let main_syntax = 'stplc'
	endif
elseif exists("b:current_syntax") && b:current_syntax == "stplc"
	finish
else
	finish
endif

"-------------------------------SYMBOL-MATCHING--------------------------------

" constants
syn case  match
"TODO: Optimize
"syn match stplcConstant  /\(\w\)\@<![A-Z][A-Z_0-9]*\(\S*[(a-z]\)\@!/
syn match stplcConstant   /\(\w\)\@<!\(\d\)\@<![A-Z_0-9]\+\(\S*[(a-z]\)\@!/

"syn match stplcParameter  /\([,(]\n\?\)\@<=\_s*\S\+\(\(\s*:=\)\|\(\s*=>\)\)\@=/

syn match stplcMethod     /\(\.\)\@<=\S\+\((\)\@=/
"syn match stplcProperty   /\(\.\)\@<=\w\+\(.*(\)\@!/
syn match stplcCustomType /\(:\)\@<=\s*\w\+\(.*\[\)\@!/

"syn match stplcVarAssign  /\(\(:=\s*\)\@<=\w\+\)\|\(\(=>\s*\)\@<=\\w\+\)\
"|\((\)\@<!\(\w\+\(\s*:\)\@=\)/
"syn match stplcVarAccess  /\w\+\(\.\)\@=/
"syn match stplcVarCall    /\(\.\)\@<!\w\+\((\)\@=/


" keywords
syn case ignore
syn keyword stplckeyword to by of

" variable types
syn case    ignore
syn keyword stplcType      string bool byte sint usint uint int dint udint lint 
                         \ ulint real lreal f_trig r_trig pvoid lword dword
syn keyword stplcPointer   pointer
syn keyword stplcReference reference
syn keyword stplcArray     array

" standard functions
syn case    ignore
syn keyword stplcSizeOf  sizeof
syn keyword stplcAdr     adr
syn keyword stplcMalloc  __new __delete
syn keyword stplcStdlib  memcpy memmove memcmp memset strlen strcpy
syn match   stplcConvert /\w*_\?TO_\w\+/
" TODO: need to add all conversion functions

" block identifiers
syn case  match
syn match stplcFunctionBlock /\(\S\)\@<!FB_[A-Za-z0-9_]*\([; \n(.\])]\)\@=/
syn match stplcStruct        /\(\S\)\@<!ST_[A-Za-z0-9_]*\([; \n(.\])]\)\@=/
syn match stplcEnumeration   /\(\S\)\@<!E_[A-Za-z0-9_]*\([; \n(.\])]\)\@=/
syn match stplcFunction      /\(\S\)\@<!F_[A-Za-z0-9_]\{-}\((\)\@=/
syn match stplcGlobalVarList /\(\S\)\@<!GVL\?_[A-Za-z0-9_]*\([; \n(.\])]\)\@=/

syn keyword stplcTaskInfo _TaskInfo
syn keyword stplcAppInfo  _AppInfo

" TODO: Finish this when I am not lazy, the idea is to differentiate different
"       variable types
" variable names
"syn case  match
"syn match stplcVariablefb        /\(\s\|^\|(\)\@<=FB_[A-Za-z]*\([; \n]\)\@=/
"syn match stplcVariablen         /\(\s*\)\@<=FB_[A-Za-z]*\([; \n]\)\@=/
"syn match stplcVariablel         /\(\s*\)\@<=ST_[A-Za-z]*\([; \n]\)\@=/
"syn match stplcVariabler         /\(\s*\)\@<=E_[A-Za-z]*\([; \n]\)\@=/
"syn match stplcVariableFunction  /\(\s*\)\@<=F_[A-Za-z]*\([; \n]\)\@=/

" control statements
syn case    ignore
syn keyword stplcConditional if else then elsif end_if case end_case
syn keyword stplcLoop        while end_while for end_for do
syn keyword stplcStatement   struct end_struct type end_type function_block 
                           \ end_function_block var end_var var_input constant
                           \ var_output var_in_out var_config program 
                           \ end_program method var_global persistent var_temp
syn keyword stplcFunction return exit

" operators
syn case    ignore
syn match   stplcOperator        /[\+\-:=<>;\^\[\]()\*/]/
syn keyword stplcShiftOperators  shr shl
syn keyword stplcBooleanOp       and or and_then or_then not xor

" values
syn case    match
syn match   stplcString   /\(".\{-}"\)\|\('.\{-}'\)/
syn keyword stplcBoolean  true false
"syn match   stplcNumber  /\([a-zA-Z_]\)\@<!-\?\d\+\([a-zA-Z_]\)\@!/
syn clear Number
syn match Number          "\v<\d+>" containedin=NONE
"syn match stplcTime       /\([Tt]#\)\@<=\S*[sS]/
syn match stplcTimeSymbol /[Tt]\(#\)\@=/

" tgawe 1 
" comments
syn case   ignore
syn match  stplcCommentSingleLine    /\/\/.*$/
syn match  stplcDocCommentSingleLine /\/\/\/.*$/
syn region stplcCommentMultiLine     start=/(\*/   skip=/(\*.*\*)/ end=/\*)/   
syn region stplcDocCommentMultiLine  start=/(\*\*/ skip=/(\*.*\*)/ end=/\*\*)/

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
"hi def link stplcNumber  Number

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
hi def link stplcPointer       stplcType
hi def link stplcEnumeration   stplcType
hi def link stplcFunctionBlock stplcType
hi def link stplcStruct        stplcType
hi def link stplcCustomType    stplcType
hi def link stplcType          Type

" functions
hi def link stplcSizeOf         stplcFunction
hi def link stplcAdr            stplcFunction
hi def link stplcMalloc         stplcFunction
hi def link stplcStdlib         stplcFunction
hi def link stplcConvert        stplcFunction
hi def link stplcShiftOperators stplcFunction
hi def link stplcFunction       Function

" statements
hi def link stplcStatement Statement

" operators
hi def link stplcOperator  Operator
hi def link stplcBooleanOp Operator

" constants
hi def link stplcAppInfo  stplcConstant 
hi def link stplcTaskInfo stplcConstnt 
hi def link stplcConstant Constant

"parameters
"hi def link stplcParameter Parameter
hi def link stplcMethod @function.method
"hi def link stplcProperty @property

hi def link stplcGlobalVarList Namespace

"hi def link stplcTime Number
hi def link stplcTimeSymbol Number

hi def link stplcVarAssign Identifier
hi def link stplcVarAccess Identifier
"hi def link stplcVarCall   Identifier

let b:current_syntax = "stplc"
