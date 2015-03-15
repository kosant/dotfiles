" Vim color scheme
"
" Name:        mycolor.vim
" Maintainer:  Ogata kazuhei
" License:     public domain
"
" Frmat base "Tomorrow Night Bright"
"

" Default GUI Colours 
"let s:foreground = "eaeaea" 
let s:background = "000000" 
"let s:foreground = "F5F1E9" 
"let s:foreground = "E6E5E1" 
let s:foreground = "DBDAD6" 
"let s:background = "262626" 
let s:selection  = "424242" 
"let s:line       = "27313D" 
"let s:line       = "2C5379" 
"let s:line       = "005F5F" 
let s:line       = "3A3A3A" 
"let s:comment    = "969896" 
let s:comment    = "767676" 
let s:window     = "4d5057" 
"let s:special    = "6B996B"
"let s:special    = "A18E5C"
let s:special    = "716341"

"let s:cream      = "F4EED8" 
let s:cream      = "FCE9B5" 

"let s:red        = "D65B70"
"let s:green      = "5BD684"
"let s:blue       = "5BADD6"
"let s:red        = "D65B6A" "353,60,60 hls
"let s:green      = "6AD65B" "113,60,60
"let s:blue       = "5BA7D6" "203,60,60
"let s:blue       = "7AA5CC" "208,40,80 HSV
"let s:blue       = "5BA5E5" "208,60,90 HSV
"let s:blue       = "72C3E5" "208,60,90 HSV

"let s:orange     = "e78c45" 
"let s:yellow     = "e7c547" 
"let s:cyan       = "c397d8" 
"let s:purple     = "c397d8" 
"let s:pink       = "70c0b1" 

let s:red        = "CC515F" "353,60,80 HSV
let s:blue       = "66AACC" "200,50,80 HSV
"let s:green      = "5DB259" "117,50,70 HSV
"let s:green      = "A2D29E" "117,50,70 HSV
let s:green      = "6B996B" "117,50,70 HSV

"let s:orange     = "E58816" " 33,90,90 HSV
"let s:orange     = "E9872E"
"let s:orange     = "E56C19"
let s:orange     = "DC572E"
"let s:yellow     = "ECB935" 
"let s:yellow     = "FFC700" 
"let s:yellow     = "E1B700" 
"let s:yellow     = "FFD464" 
"let s:yellow     = "E5BE5B" 
let s:yellow     = "F2C960" 
"let s:cyan       = "19FFE0" 
let s:cyan       = "5FAFAF" 
"let s:purple     = "D299FF" 
let s:purple     = "AB59B2" 
let s:pink       = "E589B1" 

set background=dark 
hi clear 
syntax reset 

let g:colors_name = "mycolor" 

if has("gui_running") || &t_Co == 88 || &t_Co == 256 
	" Returns an approximate grey index for the given grey level 
	fun <SID>grey_number(x) 
		if &t_Co == 88 
			if a:x < 23 
				return 0 
			elseif a:x < 69 
				return 1 
			elseif a:x < 103 
				return 2 
			elseif a:x < 127 
				return 3 
			elseif a:x < 150 
				return 4 
			elseif a:x < 173 
				return 5 
			elseif a:x < 196 
				return 6 
			elseif a:x < 219 
				return 7 
			elseif a:x < 243 
				return 8 
			else 
				return 9 
			endif 
		else 
			if a:x < 14 
				return 0 
			else 
				let l:n = (a:x - 8) / 10 
				let l:m = (a:x - 8) % 10 
				if l:m < 5 
					return l:n 
				else 
					return l:n + 1 
				endif 
			endif 
		endif 
	endfun 

	" Returns the actual grey level represented by the grey index 
	fun <SID>grey_level(n) 
		if &t_Co == 88 
			if a:n == 0 
				return 0 
			elseif a:n == 1 
				return 46 
			elseif a:n == 2 
				return 92 
			elseif a:n == 3 
				return 115 
			elseif a:n == 4 
				return 139 
			elseif a:n == 5 
				return 162 
			elseif a:n == 6 
				return 185 
			elseif a:n == 7 
				return 208 
			elseif a:n == 8 
				return 231 
			else 
				return 255 
			endif 
		else 
			if a:n == 0 
				return 0 
			else 
				return 8 + (a:n * 10) 
			endif 
		endif 
	endfun 

	" Returns the palette index for the given grey index 
	fun <SID>grey_colour(n) 
		if &t_Co == 88 
			if a:n == 0 
				return 16 
			elseif a:n == 9 
				return 79 
			else 
				return 79 + a:n 
			endif 
		else 
			if a:n == 0 
				return 16 
			elseif a:n == 25 
				return 231 
			else 
				return 231 + a:n 
			endif 
		endif 
	endfun 

	" Returns an approximate colour index for the given colour level 
	fun <SID>rgb_number(x) 
		if &t_Co == 88 
			if a:x < 69 
				return 0 
			elseif a:x < 172 
				return 1 
			elseif a:x < 230 
				return 2 
			else 
				return 3 
			endif 
		else 
			if a:x < 75 
				return 0 
			else 
				let l:n = (a:x - 55) / 40 
				let l:m = (a:x - 55) % 40 
				if l:m < 20 
					return l:n 
				else 
					return l:n + 1 
				endif 
			endif 
		endif 
	endfun 

	" Returns the actual colour level for the given colour index 
	fun <SID>rgb_level(n) 
		if &t_Co == 88 
			if a:n == 0 
				return 0 
			elseif a:n == 1 
				return 139 
			elseif a:n == 2 
				return 205 
			else 
				return 255 
			endif 
		else 
			if a:n == 0 
				return 0 
			else 
				return 55 + (a:n * 40) 
			endif 
		endif 
	endfun 

	" Returns the palette index for the given R/G/B colour indices 
	fun <SID>rgb_colour(x, y, z) 
		if &t_Co == 88 
			return 16 + (a:x * 16) + (a:y * 4) + a:z 
		else 
			return 16 + (a:x * 36) + (a:y * 6) + a:z 
		endif 
	endfun 

	" Returns the palette index to approximate the given R/G/B colour levels 
	fun <SID>colour(r, g, b) 
		" Get the closest grey 
		let l:gx = <SID>grey_number(a:r) 
		let l:gy = <SID>grey_number(a:g) 
		let l:gz = <SID>grey_number(a:b) 

		" Get the closest colour 
		let l:x = <SID>rgb_number(a:r) 
		let l:y = <SID>rgb_number(a:g) 
		let l:z = <SID>rgb_number(a:b) 

		if l:gx == l:gy && l:gy == l:gz 
			" There are two possibilities 
			let l:dgr = <SID>grey_level(l:gx) - a:r 
			let l:dgg = <SID>grey_level(l:gy) - a:g 
			let l:dgb = <SID>grey_level(l:gz) - a:b 
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb) 
			let l:dr = <SID>rgb_level(l:gx) - a:r 
			let l:dg = <SID>rgb_level(l:gy) - a:g 
			let l:db = <SID>rgb_level(l:gz) - a:b 
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db) 
			if l:dgrey < l:drgb 
				" Use the grey 
				return <SID>grey_colour(l:gx) 
			else 
				" Use the colour 
				return <SID>rgb_colour(l:x, l:y, l:z) 
			endif 
		else 
			" Only one possibility 
			return <SID>rgb_colour(l:x, l:y, l:z) 
		endif 
	endfun 

	" Returns the palette index to approximate the 'rrggbb' hex string 
	fun <SID>rgb(rgb) 
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0 
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0 
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0 

		return <SID>colour(l:r, l:g, l:b) 
	endfun 

	" Sets the highlighting for the given group 
	fun <SID>X(group, fg, bg, attr) 
		if a:fg != "" 
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg) 
		endif 
		if a:bg != "" 
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg) 
		endif 
		if a:attr != "" 
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr 
                        if a:group == "Comment"
			     exec "hi " . a:group . " gui=" . a:attr . " cterm=none" 
                        endif 
		endif 
	endfun 

	" Vim Highlighting 
	call <SID>X("Normal"      , s:foreground, s:background, "none") 
	call <SID>X("Cursor"      , s:background, s:foreground, "none") 
	call <SID>X("LineNr"      , s:selection , ""          , "none") 
	call <SID>X("NonText"     , s:selection , ""          , "none") 
	call <SID>X("SpecialKey"  , s:special   , ""          , "none") 
	call <SID>X("Search"      , s:background, s:yellow    , "none") 
	"call <SID>X("Search"      , s:foreground, s:orange    , "none") 
	"call <SID>X("TabLine"     , s:foreground, s:background, "reverse") 
	"call <SID>X("TabLineSel"  , s:foreground, s:background, "reverse") 
	"call <SID>X("StatusLine"  , s:window    , s:yellow    , "reverse") 
	"call <SID>X("StatusLineNC", s:window    , s:foreground, "reverse") 
	call <SID>X("VertSplit"   , s:window    , s:window    , "none"   ) 
	call <SID>X("Visual"      , ""          , s:selection , ""       ) 
	call <SID>X("Directory"   , s:blue      , ""          , ""       ) 
	call <SID>X("ErrorMsg"    , s:foreground, s:red       , ""       ) 
	call <SID>X("ModeMsg"     , s:foreground, ""          , ""       ) 
	call <SID>X("MoreMsg"     , s:foreground, s:green     , ""       ) 
	call <SID>X("WarningMsg"  , s:foreground, s:red       , ""       ) 
	call <SID>X("Question"    , s:foreground, s:green     , ""       ) 
	call <SID>X("MatchParen"  , ""          , s:selection , ""       ) 
	call <SID>X("Folded"      , s:cyan      , s:background, ""       ) 
	call <SID>X("FoldColumn"  , s:cyan      , s:background, ""       ) 
	call <SID>X("WildMenu  "  , ""          , s:background, ""       ) 
	if version >= 700 
		call <SID>X("CursorLine"   , ""          , s:line      , "none"   ) 
		call <SID>X("CursorColumn" , ""          , s:line      , "none"   ) 
		call <SID>X("PMenu"        , s:foreground, s:selection , "none"   ) 
		call <SID>X("PMenuSel"     , s:foreground, s:selection , "reverse") 
		call <SID>X("PMenuSbat"    , s:foreground, s:selection , "reverse") 
		call <SID>X("PMenuThub"    , s:foreground, s:selection , "reverse") 
		call <SID>X("SignColumn"   , ""          , s:background, "none"   ) 
	end 
	if version >= 703 
		call <SID>X("ColorColumn"  , ""          , s:line      , "none"   ) 
		call <SID>X("CursorLineNr" , s:yellow    , s:line      , "none"   ) 
	end 

	" Standard Highlighting 
	call <SID>X("Number"      , s:green     , ""          , "none"   ) 
	call <SID>X("Comment"     , s:comment   , ""          , "italic" ) 
	call <SID>X("Todo"        , s:comment   , s:background, "none"   ) 
	call <SID>X("Title"       , s:comment   , ""          , "none"   ) 
	call <SID>X("Identifier"  , s:cyan      , ""          , "none"   ) 
	call <SID>X("Statement"   , s:blue      , ""          , "none"   ) 
	call <SID>X("Conditional" , s:blue      , ""          , "none"   ) 
	call <SID>X("Repeat"      , s:foreground, ""          , ""       ) 
	call <SID>X("Structure"   , s:green     , ""          , ""       ) 
	call <SID>X("Function"    , s:red       , ""          , ""       ) 
	call <SID>X("Constant"    , s:cream     , ""          , ""       ) 
	call <SID>X("String"      , s:yellow    , ""          , ""       ) 
	call <SID>X("Special"     , s:red       , ""          , ""       ) 
	call <SID>X("PreProc"     , s:orange    , ""          , ""       ) 
	call <SID>X("Operator"    , s:blue      , ""          , "none"   ) 
	call <SID>X("Type"        , s:green     , ""          , "none"   ) 
	call <SID>X("Define"      , s:purple    , ""          , "none"   ) 
	call <SID>X("Include"     , s:blue      , ""          , ""       ) 
	call <SID>X("Delimiter"   , s:red       , ""          , ""       ) 
	"call <SID>X("Ignore", "666666", "", "") 

	" Vim Highlighting 
	"call <SID>X("vimCommand"  , s:blue      , ""          , "none"   ) 

	" C Highlighting 
	call <SID>X("cType", s:yellow, "", "") 
	call <SID>X("cStorageClass", s:purple, "", "") 
	call <SID>X("cConditional", s:purple, "", "") 
	call <SID>X("cRepeat", s:purple, "", "") 

	" PHP Highlighting 
	call <SID>X("phpVarSelector", s:red, "", "") 
	call <SID>X("phpKeyword", s:purple, "", "") 
	call <SID>X("phpRepeat", s:purple, "", "") 
	call <SID>X("phpConditional", s:purple, "", "") 
	call <SID>X("phpStatement", s:purple, "", "") 
	call <SID>X("phpMemberSelector", s:foreground, "", "") 

	" Ruby Highlighting 
	call <SID>X("rubySymbol", s:green, "", "") 
	call <SID>X("rubyConstant", s:yellow, "", "") 
	call <SID>X("rubyAttribute", s:blue, "", "") 
	call <SID>X("rubyInclude", s:blue, "", "") 
	call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "") 
	call <SID>X("rubyCurlyBlock", s:orange, "", "") 
	call <SID>X("rubyStringDelimiter", s:green, "", "") 
	call <SID>X("rubyInterpolationDelimiter", s:orange, "", "") 
	call <SID>X("rubyConditional", s:purple, "", "") 
	call <SID>X("rubyRepeat", s:purple, "", "") 

	" Python Highlighting 
	call <SID>X("pythonInclude", s:purple, "", "") 
	call <SID>X("pythonStatement", s:purple, "", "") 
	call <SID>X("pythonConditional", s:purple, "", "") 
	call <SID>X("pythonRepeat", s:purple, "", "") 
	call <SID>X("pythonException", s:purple, "", "") 
	call <SID>X("pythonFunction", s:blue, "", "") 

	" Go Highlighting 
	call <SID>X("goStatement", s:purple, "", "") 
	call <SID>X("goConditional", s:purple, "", "") 
	call <SID>X("goRepeat", s:purple, "", "") 
	call <SID>X("goException", s:purple, "", "") 
	call <SID>X("goDeclaration", s:blue, "", "") 
	call <SID>X("goConstants", s:yellow, "", "") 
	call <SID>X("goBuiltins", s:orange, "", "") 

	" CoffeeScript Highlighting 
	call <SID>X("coffeeKeyword", s:purple, "", "") 
	call <SID>X("coffeeConditional", s:purple, "", "") 

	" JavaScript Highlighting 
	call <SID>X("javaScriptBraces", s:foreground, "", "") 
	call <SID>X("javaScriptFunction", s:purple, "", "") 
	call <SID>X("javaScriptConditional", s:purple, "", "") 
	call <SID>X("javaScriptRepeat", s:purple, "", "") 
	call <SID>X("javaScriptNumber", s:orange, "", "") 
	call <SID>X("javaScriptMember", s:orange, "", "") 

	" HTML Highlighting 
	call <SID>X("htmlTag", s:red, "", "") 
	call <SID>X("htmlTagName", s:red, "", "") 
	call <SID>X("htmlArg", s:red, "", "") 
	call <SID>X("htmlScriptTag", s:red, "", "") 

	" Diff Highlighting 
	"call <SID>X("DiffAdded", s:green, "", "") 
	"call <SID>X("DiffRemoved", s:red, "", "") 
	call <SID>X("DiffAdd"   , s:cream     , s:green     , "none") 
	call <SID>X("DiffDelete", s:cream     , s:red       , "none") 
	call <SID>X("DiffChange", s:cream     , s:cyan      , "none") 
	call <SID>X("DiffText"  , s:pink      , s:foreground, "none") 

	" Delete Functions 
	delf <SID>X 
	delf <SID>rgb 
	delf <SID>colour 
	delf <SID>rgb_colour 
	delf <SID>rgb_level 
	delf <SID>rgb_number 
	delf <SID>grey_colour 
	delf <SID>grey_level 
	delf <SID>grey_number 
endif 


function! ZenkakuSpace()
  "highlight ZenkakuSpace cterm=underline ctermbg=lightblue ctermfg=lightblue guibg=darkgray
  highlight ZenkakuSpace cterm=underline ctermbg=167 ctermfg=167 guibg=#CC515F guifg=#CC515F
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif

