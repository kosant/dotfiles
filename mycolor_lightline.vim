" =============================================================================
" Filename: autoload/lightline/colorscheme/mycolor_lightline.vim
" Version: 0.0
" Author: itchyny
" License: MIT License
" Last Change: 2013/09/07 12:21:04.
" =============================================================================
let s:base03 = [ '#121212', 233 ]
let s:base02 = [ '#303030 ', 236 ]
let s:base01 = [ '#4e4e4e', 239 ]
let s:base00 = [ '#6C6C6C', 242  ]
let s:base0 = [ '#808080', 244 ]
let s:base1 = [ '#949494', 246 ]
let s:base2 = [ '#a8a8a8', 248 ]
let s:base3 = [ '#DADADA', 253 ]
let s:yellow = [ '#FFD75F', 221 ]
let s:orange = [ '#FFD787', 222 ]
"let s:red = [ '#D75F5F', 167 ]
let s:red = [ '#D75f5f', 167 ]
let s:white = [ '#FFFFFF', 15 ]
let s:magenta = [ '#ffafaf', 217 ]
"let s:blue = [ '#87afd7', 110 ]
"let s:blue = [ '#8197bf', 60 ]
"let s:blue = [ '#87afd7', 110 ]
let s:blue = [ '#5f87af', 67 ]
let s:blue1 = [ '#afd7ff', 195 ]
"let s:cyan = [ '#D787d7', 176 ]
"let s:cyan = [ '#D7afd7', 182 ]
let s:cyan = [ '#af5f87', 132 ]
"let s:green = [ '#99ad6a', 121 ]
"let s:green = [ '#99ad6a', 73 ]
"let s:green = [ '#99ad6a', 65 ]
"let s:green = [ '#87d7af', 115 ]
let s:green = [ '#5F875F', 65 ]
let s:green1 = [ '#D7FFAF', 193 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:white, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base2, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:white, s:green ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:white, s:red ], [ s:base3, s:base01 ] ]
"let s:p.visual.left = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:white, s:cyan ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base0, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base02 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base1 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:base02 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base01 ] ]

let g:lightline#colorscheme#mycolor_lightline#palette = lightline#colorscheme#flatten(s:p)
