""----------------------------------------------------------------------""
"" Initialize {{{

"" Don't use Vi-compatible mode
"" Vi-compatible mode is default on, but off when a vimrc file is found.
"" set nocompatible
if &compatible
  set nocompatible
endif

"" Check platform {{{
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')

function! IsWindows()
  return s:is_windows
endfunction

function! IsMac()
  return !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))
endfunction
"" }}}

"" Use ',' instead of '\'.
"" Use <Leader> in global plugin.
let g:mapleader = ','
"" Use <LocalLeader> in filetype plugin.
let g:maplocalleader = 'm'

"" Release keymappings for plug-in.
nnoremap ;  <Nop>
xnoremap ;  <Nop>
nnoremap m  <Nop>
xnoremap m  <Nop>
nnoremap ,  <Nop>
xnoremap ,  <Nop>

if IsWindows()
  "" Exchange path separator.
  set shellslash
endif

"" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

"" Disable netrw.vim
let g:loaded_netrwPlugin = 1
"" }}}
""----------------------------------------------------------------------""
"" Pulgin {{{

"" Start setting"{{{
if has('vim_starting')
  "" Set runtimepath.
  if IsWindows()
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
  else
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif
endif

if IsWindows()
  call neobundle#begin(expand('~/vimfiles/bundle/'))
else
  call neobundle#begin(expand('~/.vim/bundle/'))
endif"}}}
"" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

"" Pulgin list {{{
"" My Bundles here:
"" Refer to |:NeoBundle-examples|.
"" You don't set neobundle setting in .gvimrc!
"" Synthesis"{{{
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin'  : 'make -f make_cygwin.mak',
      \     'mac'     : 'make -f make_mac.mak',
      \     'linux'   : 'make',
      \     'unix'    : 'gmake',
      \    }
      \ }
NeoBundleLazy 'Shougo/vimshell.vim', {
      \ 'commands' : [{ 'name' : 'VimShell',
      \                 'complete' : 'customlist,vimshell#complete'},
      \               ],
      \ 'mappings' : '<Plug>'
      \ }
NeoBundleLazy 'Shougo/vimfiler.vim', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'commands' : [
      \         { 'name' : ['VimFiler', 'Edit', 'Write']},
      \         'Read', 'Source'],
      \ 'mappings' : '<Plug>',
      \ 'explorer' : 1,
      \ }
"}}}

"" Unite "{{{
NeoBundleLazy 'Shougo/unite.vim', {
      \ 'commands' : [{ 'name' : 'Unite'}],
      \ 'depends' : ['Shougo/neomru.vim',
      \             'basyura/unite-converter-file-directory',
      \             'basyura/unite-matchers']
      \ }
NeoBundleLazy 'Shougo/neomru.vim', {
      \ 'filetypes' : 'all'
      \ }
NeoBundleLazy 'Shougo/tabpagebuffer.vim', {
      \ 'filetypes' : 'all'
      \ }
NeoBundleLazy 'Shougo/unite-outline'
NeoBundleLazy 'ujihisa/unite-colorscheme'
NeoBundleLazy 'basyura/unite-converter-file-directory'
NeoBundleLazy 'basyura/unite-matchers'
NeoBundleLazy 'osyo-manga/unite-fold'
NeoBundleLazy 'tacroe/unite-mark'
"}}}

"" UI"{{{
NeoBundle 'itchyny/lightline.vim'
NeoBundleLazy 'LeafCage/foldCC.vim', {
      \ 'filetypes' : 'vim' }
NeoBundleLazy 't9md/vim-quickhl', {
    \ 'autoload' : {
    \   'commands' : ["QuickhlAdd"],
    \   'mappings' : ["<Plug>(quickhl-manual-this)", "<Plug>(quickhl-manual-toggle)", "<Plug>(quickhl-manual-reset)"],
    \   },
    \}
"}}}

"" Operators "{{{
NeoBundleLazy 'kana/vim-operator-user', {
      \   'functions' : 'operator#user#define',
      \ }
NeoBundleLazy 'kana/vim-operator-replace', {
      \ 'depends' : 'vim-operator-user',
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nx', '<Plug>(operator-replace)']]
      \ }}
NeoBundleLazy 'rhysd/vim-operator-surround', {
      \ 'depends' : 'vim-operator-user',
      \   'mappings' : '<Plug>',
      \ }
"}}}

"" Textobjs "{{{
NeoBundleLazy 'kana/vim-textobj-user'
NeoBundleLazy 'osyo-manga/vim-textobj-multiblock', {
      \ 'depends' : 'vim-textobj-user',
      \ 'autoload' : {
      \   'mappings' : [
      \     ['ox', '<Plug>']]
      \ }}
"}}}

"" Motion"{{{
NeoBundleLazy 'osyo-manga/vim-anzu', {
      \   'autoload' : {
      \     'mappings' : ['<Plug>(anzu-'],
      \   }
      \}
NeoBundleLazy 'saihoooooooo/glowshi-ft.vim', {
      \ 'mappings' : '<Plug>'
      \ }
NeoBundleLazy 'Lokaltog/vim-easymotion', {
      \ 'mappings' : '<Plug>(easymotio-',
      \}
NeoBundleLazy 'junegunn/vim-easy-align', {
      \ 'mappings' : '<Plug>(EasyAlign)',
      \}
"}}}

"" Useful Tool"{{{
NeoBundleLazy 'tyru/restart.vim', {
      \ 'gui' : 1,
      \ 'commands' : 'Restart',
      \ }
NeoBundleLazy 'tyru/caw.vim', {
      \   'autoload' : {
      \     'mappings' : ['<Plug>(caw'],
      \   }
      \}
NeoBundle 'glidenote/memolist.vim'
NeoBundleLazy 'thinca/vim-fontzoom', {
      \ 'gui' : 1,
      \ 'autoload' : {
      \  'mappings' : '<Plug>'
      \ }}
"}}}


"" Don't use pulgin"{{{
" NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'taka-vagyok/prevent-win-closed.vim'
" NeoBundle 'Lokaltog/vim-powerline '
" NeoBundle 'cocopon/lightline-hybrid.vim'
" NeoBundle 'Shougo/unite-help'
" NeoBundle 'vim-jp/vimdoc-ja'
" NeoBundle 'Yggdroot/indentLine'
" NeoBundle 'vim-scripts/Colour-Sampler-Pack'
" NeoBundle 'tomtom/tcomment_vim'

"}}}
"" Don't use lazy"{{{
" NeoBundle 'Shougo/unite.vim'
" NeoBundle 'Shougo/neomru.vim'
" NeoBundle 'Shougo/tabpagebuffer.vim'
" NeoBundle 'Shougo/unite-outline'
" NeoBundle 'ujihisa/unite-colorscheme'
" NeoBundle 'basyura/unite-converter-file-directory'
" NeoBundle 'basyura/unite-matchers'
" NeoBundle 'osyo-manga/unite-fold'
" NeoBundle 'Shougo/vimfiler.vim'
" NeoBundle 'LeafCage/foldCC.vim'
" NeoBundle 'itchyny/lightline.vim'
" NeoBundle 'tomtom/tcomment_vim'
" NeoBundle 'tyru/caw.vim'
" NeoBundle 't9md/vim-quickhl'
" NeoBundle 'Lokaltog/vim-easymotion'
"}}}
""}}}

"" Pulgin setting {{{
if neobundle#tap('vimshell.vim') "{{{
  " <C-Space>: switch to vimshell.
  nmap <C-@>  <Plug>(vimshell_switch)
  nnoremap !  q:VimShellExecute<Space>
  nnoremap [Space]i  q:VimShellInteractive<Space>
  nnoremap [Space]t  q:VimShellTerminal<Space>

  " let neobundle#hooks.on_source =
  "       \ '~/.vim/rc/plugins/vimshell.rc.vim'
  function! neobundle#hooks.on_source(bundle)
    let g:vimshell_force_overwrite_statusline = 0
  endfunction

  call neobundle#untap()
endif "}}}
if neobundle#tap('unite.vim') "{{{
  nnoremap [unite]    <Nop>
  nmap     <Space>u [unite]
  nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> <F3>     :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> [unite]u :<C-u>Unite file_mru buffer<CR>
  nnoremap <silent> <F2>     :<C-u>Unite file_mru buffer<CR>
  "nnoremap <silent> <F2>     :<C-u>Unite startup_file_mru buffer<CR>
  nnoremap <silent> [unite]m :<C-u>Unite menu<CR>
  nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
  nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
  nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
  nnoremap <silent> ,um :<C-u>Unite menu<CR>

  function! neobundle#hooks.on_source(bundle)
     "" Unite setting
    "let g:unite_enable_start_insert=1
    let g:unite_source_history_yank_enable =1
    let g:unite_force_overwrite_statusline=0
    let g:unite_source_file_mru_limit = 200
    "" using unite.vim key map
    autocmd MyAutoCmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()
        "" ESC is unite quit
        "nmap <buffer> <ESC> <Plug>(unite_exit)
        nmap <silent><buffer> <ESC><ESC> q
        imap <silent><buffer> <ESC><ESC> <ESC>q
        nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
        nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
    endfunction

    call unite#custom_source('file_mru,buffer', 'matchers',
          \ ['matcher_file_name'])
    call unite#custom_source('file_mru,buffer', 'converters',
          \ [ 'converter_file_directory'])

     let g:unite_source_menu_menus = {
          \   "shortcut" : {
          \       "description" : "sample unite-menu",
          \       "command_candidates" : [
          \           ["edit vimrc", "edit $MYVIMRC"],
          \           ["edit gvimrc", "edit $MYGVIMRC"],
          \           ["unite-file_mru", "Unite file_mru"],
          \           ["Unite Beautiful Attack", "Unite -auto-preview colorscheme"],
          \           ["unite-output:message", "Unite output:message"],
          \           ["VimFiler", ":VimFiler -buffer-name=explorer -split -horizontal -winheight=15 -toggle -no-quit"],
          \       ],
          \   },
          \}

    let g:unite_source_alias_aliases = {
    \    "startup_file_mru" : {
    \        "source" : "file_mru",
    \    },
    \    "startup_directory_mru" : {
    \        "source" : "directory_mru",
    \    },
    \}

    if !exists("g:unite_source_menu_menus")
        let g:unite_source_menu_menus = {}
    endif

    let g:unite_source_menu_menus.startup = {
    \    "description" : "startup_menu",
    \    "command_candidates" : [
    \        [ "vimrc",  "edit " . $MYVIMRC ],
    \        [ "gvimrc", "edit " . $MYGVIMRC ],
    \        [ "unite-file_mru", "Unite file_mru"],
    \        [ "unite-directory_mru", "Unite directory_mru" ],
    \    ]
    \}

    call unite#custom_max_candidates("startup_file_mru", 5)
    call unite#custom_max_candidates("startup_directory_mru", 5)

    command! UniteStartup
          \   Unite
          \   output:echo:"===:file:mru:===":! startup_file_mru
          \   output:echo:":":!
          \   output:echo:"===:directory:mru:===":! startup_directory_mru
          \   output:echo:":":!
          \   output:echo:"===:menu:===":! menu:startup
          \   -hide-source-names
          \   -no-split
          \   -quick-match
    "++++++++++++++++++++++++ test +++++++++++++++++++++++
  endfunction

  call neobundle#untap()
endif ""}}}
if neobundle#tap('vimfiler.vim') "{{{
  "nnoremap <silent> <C-e> :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<CR>
  "nnoremap <silent> <C-e> :VimFiler -buffer-name=explorer -winwidth=45 -toggle -no-quit<CR>
  "nnoremap <silent> <C-e> :<C-u>VimFiler -buffer-name=explorer -split -horizontal -winheight=15 -toggle -no-quit<CR>
  "nnoremap <silent> <F1>  :<C-u>VimFiler -buffer-name=explorer -split -horizontal -winheight=15 -toggle -no-quit<CR>
  "nnoremap <silent> <C-e> :<C-u>VimFiler -toggle<CR>
  "nnoremap <silent> <F1>  :<C-u>VimFiler -toggle<CR>
  " nnoremap <silent> <C-e> :<C-u>VimFiler -buffer-name=explorer -split -horizontal -winheight=15 -toggle -force-quit<CR>
  nnoremap <silent> <C-e> :<C-u>VimFiler -buffer-name=explorer -split             -winwidth=45  -toggle -no-quit<CR>
  nnoremap <silent> <F1>  :<C-u>VimFiler -buffer-name=explorer -split -horizontal -winheight=15 -toggle -force-quit<CR>
  function! neobundle#hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer=1
    let g:vimfiler_force_overwrite_statusline=0
    "autocmd FileType vimfiler
    "        \ nnoremap <buffer><silent>/
    "        \ :<C-u>Unite file -default-action=vimfiler<CR>
    autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
    function! s:vimfiler_my_settings()
        "" ESC is vimfiler quit
        "nmap <buffer> <ESC> <Plug>(unite_exit)
        nmap <silent><buffer> <ESC><ESC> q
        imap <silent><buffer> <ESC><ESC> <ESC>q
    endfunction


  endfunction
  call neobundle#untap()
endif ""}}}
if neobundle#tap('lightline.vim') "{{{
  let g:lightline = {
          \ 'colorscheme': 'mycolor_lightline',
          \ 'mode_map': {'c': 'NORMAL'},
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'anzu'] ],
          \   'right': [ [ 'lineinfo' ],
          \              [ 'percent' ],
          \              [ 'bufnum', 'fileformat', 'fileencoding', 'filetype' ] ]
          \ },
          \ 'component':{
          \   'lineinfo': '%3l/%L:%-2v'
          \},
          \ 'component_function': {
          \   'modified': 'MyModified',
          \   'readonly': 'MyReadonly',
          \   'fugitive': 'MyFugitive',
          \   'filename': 'MyFilename',
          \   'fileformat': 'MyFileformat',
          \   'filetype': 'MyFiletype',
          \   'fileencoding': 'MyFileencoding',
          \   'mode': 'MyMode',
          \   'bufnum': 'CountBuffers',
          \   'anzu': 'anzu#search_status'
          \ }
          \ }

  function! MyModified() "{{{
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction "}}}
  function! MyReadonly() "{{{
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
  endfunction "}}}
  function! MyFilename() "{{{
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
          \  &ft == 'unite' ? unite#get_status_string() :
          \  &ft == 'vimshell' ? vimshell#get_status_string() :
          \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction "}}}
  function! MyFugitive() "{{{
    try
      if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
      endif
    catch
    endtry
    return ''
  endfunction "}}}
  function! MyFileformat() "{{{
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction "}}}
  function! MyFiletype() "{{{
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction "}}}
  function! MyFileencoding() "{{{
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction "}}}
  function! MyMode() "{{{
    return winwidth(0) > 60 ? lightline#mode() : ''
  endfunction "}}}
  call neobundle#untap()
endif ""}}}
if neobundle#tap('memolist.vim') "{{{
  nnoremap <Leader>mn  :MemoNew<CR>
  nnoremap <Leader>ml  :MemoList<CR>
  nnoremap <Leader>mg  :MemoGrep<CR>
  "let g:memolist_vimfiler = 1
  let g:memolist_unite = 1
  call neobundle#untap()
endif ""}}}
if neobundle#tap('vim-quickhl') "{{{
    nmap <Space>m <Plug>(quickhl-manual-this)
    xmap <Space>m <Plug>(quickhl-manual-this)
    nmap <Space>j <Plug>(quickhl-manual-toggle)
    xmap <Space>j <Plug>(quickhl-manual-toggle)

    nmap <Space>M <Plug>(quickhl-manual-reset)
    xmap <Space>M <Plug>(quickhl-manual-reset)

  call neobundle#untap()
endif ""}}}
if neobundle#tap('vim-operator-replace') "{{{
  xmap p <Plug>(operator-replace)
  map  R <Plug>(operator-replace)

  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-operator-surround') "{{{
  nmap <silent>sa <Plug>(operator-surround-append)a
  nmap <silent>sd <Plug>(operator-surround-delete)a
  "nmap <silent>sr <Plug>(operator-surround-replace)a
  nmap <silent>sc <Plug>(operator-surround-replace)a
  "" How to use -> Tips
  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-textobj-user') "{{{
  let g:textobj_multiblock_blocks = [
  \  [ "(", ")" ],
  \  [ "[", "]" ],
  \  [ '<', '>' ],
  \  [ "{", "}" ],
  \  [ '"', '"', 1 ],
  \  [ "'", "'", 1 ],
  \]

  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  xmap ab <Plug>(textobj-multiblock-a)
  xmap ib <Plug>(textobj-multiblock-i)

  call neobundle#untap()
endif "}}}
if neobundle#tap('glowshi-ft.vim') "{{{
  let g:glowshi_ft_no_default_key_mappings = 1
  map f <Plug>(glowshi-ft-f)
  map F <Plug>(glowshi-ft-F)

  let g:glowshi_ft_timeoutlen = 2000
  let g:glowshi_ft_selected_hl_link = 'DiffChange'
  let g:glowshi_ft_candidates_hl_link = 'DiffDelete'

  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-easymotion') "{{{
  function! neobundle#tapped.hooks.on_source(bundle) "{{{
    " EasyMotion Config {{{
    let g:EasyMotion_do_mapping = 0
    " let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTZXCVBASDGJF'
    let g:EasyMotion_keys = ';HKLYUIONM,WERTXCVBASDGJF'
    " Do not shade
    let g:EasyMotion_do_shade = 0
    " Use upper case
    let g:EasyMotion_use_upper = 1
    " Smartcase
    let g:EasyMotion_smartcase = 1
    " pseudo-migemo
    let g:EasyMotion_use_migemo = 1
    " Jump to first with enter & space
    " let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_space_jump_first = 1
    " Prompt
    let g:EasyMotion_prompt = '{n}> '
    " Highlight cursor
    " let g:EasyMotion_cursor_highlight = 1
    "}}}

    " EasyMotion Regrex {{{
    let g:EasyMotion_re_line_anywhere = '\v' .
    \  '(<.|^.)' . '|' .
    \  '(.>|.$)' . '|' .
    \  '(\s+\zs.)' . '|' .
    \  '(\l)\zs(\u)' . '|' .
    \  '(_\zs.)' . '|' .
    \  '(#\zs.)'
    let g:EasyMotion_re_anywhere = '\v' .
    \  '(<.|^)' . '|' .
    \  '(.$)' . '|' .
    \  '(\s+\zs.)' . '|' .
    \  '(\l)\zs(\u)' . '|' .
    \  '(_\zs.)' . '|' .
    \  '(/\zs.)' . '|' .
    \  '(#\zs.)'
    "}}}

  " EasyMotion Mapping
  nmap ,s <Plug>(easymotion-s2)
  vmap ,s <Plug>(easymotion-s2)
  omap ,z <Plug>(easymotion-s2)
  nmap gr <Plug>(easymotion-sn)
  xmap gr <Plug>(easymotion-sn)
  omap gr <Plug>(easymotion-sn)

  nmap <C-n> <Plug>(easymotion-next)
  nmap <C-p> <Plug>(easymotion-prev)
  xmap <C-n> <Plug>(easymotion-next)
  xmap <C-p> <Plug>(easymotion-prev)
    autocmd MyAutoCmd FileType unite call s:easymotion_my_settings()
    function! s:easymotion_my_settings() "{{{
       " nnoremap h     <Plug>(easymotion-next)
       " nnoremap l     <Plug>(easymotion-prev)
       " nnoremap <C-n> <Plug>(easymotion-next)
       " nnoremap <C-p> <Plug>(easymotion-prev)

       " xmap h     <Plug>(easymotion-next)
       " xmap l     <Plug>(easymotion-prev)
       " xmap <C-n> <Plug>(easymotion-next)
       " xmap <C-p> <Plug>(easymotion-prev)
    endfunction "}}}
  endfunction "}}}
  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-fontzoom') "{{{
  nmap + <Plug>(fontzoom-larger)
  nmap _ <Plug>(fontzoom-smaller)

  call neobundle#untap()
endif "}}}
if neobundle#tap('restart.vim') "{{{
  let g:restart_save_window_values = 0
  let g:restart_sessionoptions
    \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'
  nnoremap <silent> <Space>re  :<C-u>Restart<CR>

  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-anzu') "{{{
  nmap <expr> n <SID>search_forward_p() ? '<Plug>(anzu-n)zzzv' : '<Plug>(anzu-N)zzzv'
  nmap <expr> N <SID>search_forward_p() ? '<Plug>(anzu-N)zzzv' : '<Plug>(anzu-n)zzzv'
  vmap <expr> n <SID>search_forward_p() ? '<Plug>(anzu-n)zzzv' : '<Plug>(anzu-N)zzzv'
  vmap <expr> N <SID>search_forward_p() ? '<Plug>(anzu-N)zzzv' : '<Plug>(anzu-n)zzzv'
  omap <expr> n <SID>search_forward_p() ? '<Plug>(anzu-n)zzzv' : '<Plug>(anzu-N)zzzv'
  omap <expr> N <SID>search_forward_p() ? '<Plug>(anzu-N)zzzv' : '<Plug>(anzu-n)zzzv'
  function! s:search_forward_p() "{{{
    return exists('v:searchforward') ? v:searchforward : 1
  endfunction "}}}
  nmap * <Plug>(anzu-star)
  nmap # <Plug>(anzu-sharp)
  nmap g* g*<Plug>(anzu-update-search-status)
  nmap g# g#<Plug>(anzu-update-search-status)
  " nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
  nmap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>
  \ <Plug>(anzu-clear-search-status)
  " let g:anzu_status_format = "(%i/%l)"
  call neobundle#untap()
endif "}}}
if neobundle#tap('caw.vim') "{{{
  " nmap <C-Enter> yy<Plug>(caw:i:comment)p
  nmap <C-Enter> yypk<Plug>(caw:i:comment)j
  nmap gcc <Plug>(caw:i:toggle)
  vmap gcc <Plug>(caw:i:toggle)
  call neobundle#untap()
endif "}}}
if neobundle#tap('vim-easy-align') "{{{
  let g:easy_align_delimiters = {
  \ '>': { 'pattern': '>>\|=>\|>' },
  \ '/': {
  \     'pattern':         '//\+\|/\*\|\*/',
  \     'delimiter_align': 'l',
  \     'ignore_groups':   ['!Comment'] },
  \ ']': {
  \     'pattern':       '[[\]]',
  \     'left_margin':   0,
  \     'right_margin':  0,
  \     'stick_to_left': 0
  \   },
  \ ')': {
  \     'pattern':       '[()]',
  \     'left_margin':   0,
  \     'right_margin':  0,
  \     'stick_to_left': 0
  \   },
  \ 'd': {
  \     'pattern':      ' \(\S\+\s*[;=]\)\@=',
  \     'left_margin':  0,
  \     'right_margin': 0
  \   }
  \ }
  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  xmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)
endif "}}}
""}}}

call neobundle#end()

filetype plugin indent on

" Enable syntax color.
syntax on

if !has('vim_starting')
  "" Installation check.
  "NeoBundleCheck
endif
""}}}
""----------------------------------------------------------------------""
"" Encoding {{{
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
""}}}
""----------------------------------------------------------------------""
"" Search  {{{
"" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
"" Enable incremental search.
set incsearch
"" When there is a previous search pattern, highlight all its matches.
set hlsearch
"" Searches wrap around the end of the file.
set wrapscan
"" When a bracket is inserted, briefly jump to the matching one.
set showmatch
set matchtime=2
"" Search word of cursor to help. command -> K
set keywordprg=:help
""grep key
set grepprg=grep\ -rnIH\ --exclude-dir=.svn\ --exclude-dir=.git

if version >= 702
  "" vimgrep auto cwindow :vimgrep {pattern} {file} | cw
  autocmd MyAutoCmd QuickFixCmdPost *grep* cwindow
  "" Open a window to show the quickfix-window
  autocmd MyAutoCmd QuickfixCmdPost vimgrep copen
  autocmd MyAutoCmd QuickfixCmdPost grep copen
endif

""}}}
""----------------------------------------------------------------------""
"" Edit {{{
"" saving, and swap files will keep you safe if your computer crashes.
set hidden
"" Over line is cursor
set whichwrap=b,s,h,l,<,>,[,]
"" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
"" <C-a><C-x> Increment or Decrement [a-z]
set nrformats=alpha,octal,hex
"" Timeoutlen=maping wait, ttimeoutlen=keycode wait
"set timeout timeoutlen=500 ttimeoutlen=100
set timeout timeoutlen=800 ttimeoutlen=100
"" Opne file of directory is current directory
autocmd MyAutoCmd BufEnter * execute ":lcd " . (isdirectory(expand("%:p:h")) ? expand("%:p:h") : "")
"" Version check
if version >= 702
  "" Better insert-mode-line completion
  set completeopt=menuone,preview
  set pumheight=10
endif

"" Show partial commands in the last line of the screen
set showcmd
"" Set the command window height to 2 lines, to avoid many cases of having to
set cmdheight=2
"" Better command-line completion
set wildmenu wildmode=list:longest
"set wildmenu wildmode=list:full
"" The command-lines that you enter are remembered in a history table.
set history=1000

"" Smart insert tab setting.
set smarttab
"" Indentation settings for using 2 spaces instead of tabs.
set shiftwidth=2
set softtabstop=2
set expandtab

"" Ignore case on insert completion.
set infercase
"" No set undofile
set noundofile
"" No-swap
set noswapfile
"" No backup file
set nobackup
""}}}
""----------------------------------------------------------------------""
"" View {{{
"" Anywhere SID.
function! s:SID_PREFIX() "{{{
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction "}}}
"" The title of the window will be set to the value of filename
set title
"" Set tabline.
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2
function! s:my_tabline()  "{{{
  let s = ''

  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears

    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '

    " Use gettabvar().
    let title =
          \ !exists('*gettabvar') ?
          \      fnamemodify(bufname(bufnr), ':t') :
          \ gettabvar(i, 'title') != '' ?
          \      gettabvar(i, 'title') :
          \      fnamemodify((i == tabpagenr() ?
          \       getcwd() : gettabvar(i, 'cwd')), ':t')

    let title = '[' . title . ']'

    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= title
    let s .= mod
    let s .= '%#TabLineFill#'
  endfor

  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
"" Display line numbers on the left
set number
"" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=8
""  When included, as much as possible of the last line in a window will be displayed.
set display=lastline
"" Show statusline
"set statusline=%F%r%h%=%l\ %p%%
if version >= 702
  set statusline=%f%m%r%h%w\%=%{CountBuffers()}\ \|\ %Y\ \|\ %{&ff}\ \|\ %l/%L\ \|\ %p%%\ \
  function! CountBuffers() "{{{
    let cnt = 0
    for nr in range(1, bufnr('$'))
      if buflisted(nr)
        "let cnt += 1
        let cnt = cnt + 1
      endif
    endfor
      return cnt
  endfunction "}}}
else
  set statusline=%f%m%r%h%w\%=\ \|\ %Y\ \|\ %{&ff}\ \|\ %l/%L\ \|\ %p%%\ \
endif
"" Always display the status line, even if only one window is displayed
set laststatus=2

"" Turn down a long line appointed in 'breakat'
set linebreak
set showbreak=\
set breakat=\ \	;:,!?
if exists('+breakindent')
  set breakindent
  set wrap
else
  "set nowrap
endif

"" Do not display greetings message at the time of Vim start.
set shortmess=aTI

"" Display fold line on the left
set foldcolumn=3
set fillchars=vert:\|
set commentstring=%s
"" Use FoldCCtext().
set foldtext=FoldCCtext()

"" display unprintable characters
set list
"set listchars=tab:^-,trail:-,eol:\
"set listchars=tab:>-,extends:<,trail:-,eol:<
"set listchars=tab:>-,extends:<,trail:-
"set listchars=tab:>-
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,
"" Disable bell
set t_vb=
set novisualbell
"" Report changes.
set report=0
"" Maintain a current line at the time of movement as much as possible.
set nostartofline
"" No equal window size.
set noequalalways
"" Don't redraw while macro executing.
set lazyredraw
set ttyfast
"" Splitting a window will put the new window below the current one.
set splitbelow
"" Splitting a window will put the new window right the current one.
set splitright
"" Version check
if version >= 702
  "" Highlight the screen line of the cursor with CursorLine
  set cursorline
  "set cursorcolumn
endif

"" When editing a file, always jump to the last cursor position
autocmd MyAutoCmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

"" Enable modeline.
set modeline
"" Enable the use of the mouse.
"set mouse=a
"" Disable the use of the mouse
set mouse-=a
"" Using windous clipboard
"set clipboard+=unnamed
set clipboard+=unnamed,unnamedplus
"" Disable automatically insert comment
"autocmd FileType * setlocal formatoptions-=ro
autocmd MyAutoCmd FileType * set formatoptions-=ro
" Reload .vimrc automatically.
autocmd MyAutoCmd BufWritePost .vimrc,*.rc.vim
      \ NeoBundleClearCache | source $MYVIMRC | redraw
""}}}
""----------------------------------------------------------------------""
"" FileType {{{
autocmd BufNewFile,BufRead *.psl set filetype=verilog
autocmd BufNewFile,BufRead *.sv set filetype=verilog
autocmd BufNewFile,BufRead *.vunit set filetype=verilog
""}}}
""----------------------------------------------------------------------""
"" Key Mappings {{{
"" Mappings Tips{{{
""-------------------------------------------------------------------------------------"
"" command         | normal   | insert | commandline    | visual     | sel  | calwait  |
"" map  / noremap  |    @     |  -     |       -        |     @      |  @   |    @     |
"" nmap / nnoremap |    @     |  -     |       -        |     -      |  -   |    -     |
"" vmap / vnoremap |    -     |  -     |       -        |     @      |  @   |    -     |
"" omap / onoremap |    -     |  -     |       -        |     -      |  -   |    @     |
"" xmap / xnoremap |    -     |  -     |       -        |     @      |  -   |    -     |
"" smap / snoremap |    -     |  -     |       -        |     -      |  @   |    -     |
"" map! / noremap! |    -     |  @     |       @        |     -      |  -   |    -     |
"" imap / inoremap |    -     |  @     |       -        |     -      |  -   |    -     |
"" cmap / cnoremap |    -     |  -     |       @        |     -      |  -   |    -     |
""-------------------------------------------------------------------------------------"
"}}}

"" Normal and Visual mode keymappings {{{
"" <Enter> always means insetrting line.
nnoremap <S-Enter> O<ESC>
nnoremap <Enter> o<ESC>
"" Key map ^,$ to <Space>h,l
"" Because ^ and $ is difficult to type and damage little finger!!!
noremap <Space>h ^
noremap <Space>l $
"" Easy move
nnoremap <silent><Space><Space> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
nnoremap <silent><S-Space>  <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
"" Switch j,k and gj,gk
nnoremap <silent> j gj
nnoremap <silent> k gk
"" When move to search results, move to center.
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz
""  -> vim-anzu
"" Yank
nnoremap Y y$
nnoremap pp "0p
noremap x "_x
"" Disable because this is dangerous key
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
"nnoremap Q gq
nnoremap Q <Nop>
"" clear hightliht search
""  -> vim-anzu
" nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>
nnoremap <C-s> i <Esc><Right>
nnoremap <C-j> O<Esc><Down>
nnoremap <C-k> <Up>dd
"" Easy Replacement
nnoremap gs  :<C-u>%s///g<Left><Left><Left>
"" Auto input of grep word
nnoremap <expr> <Space>g ':vimgrep /\<' . expand('<cword>') . '\>/j **/*.' . expand('%:e')
nnoremap <expr> <Space>G ':sil grep! ' . expand('<cword>') . ' *'
""}}}

"" Window and tab"{{{
"" Don't use s
nnoremap s <Nop>
"" Active window move
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
"" Change window
nnoremap sr <C-w>r
"" Resize window
nnoremap sO <C-w>=
nnoremap <kPlus>     <C-w>+
nnoremap <kMinus>    <C-w>-
nnoremap <kDivide>   <C-w>>
nnoremap <kMultiply> <C-w><
"" Sepalate horizonral
nnoremap ss :<C-u>sp
"" Sepalate vertical
nnoremap sv :<C-u>vs

"" Tab move
nnoremap sn gt
nnoremap sp gT
"" Create new tab
nnoremap st :<C-u>tabnew
"}}}

"" Insert and Command-line mode keymappings: {{{
"" <C-a>, A: move to head
inoremap <C-a>  <HOME>
"" <C-e>, E: move to end
inoremap <C-e>  <END>
"" Cursor move
noremap! <C-k> <Up>
noremap! <C-j> <Down>
noremap! <C-h> <Left>
noremap! <C-l> <Right>
noremap! <silent> <C-b> <BS>
noremap! <silent> <C-d> <Del>
"" Easy escape
inoremap jj <Esc>
cnoremap jj <C-[><CR>

inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <> <><LEFT>

"" <C-t>: insert tab.
inoremap <C-t>  <C-v><TAB>

" cnoremap <Enter> <CR>
"" Auto escape / and ? in search command.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

""}}}

"" Paste using mouse
noremap  <S-Insert> <MiddleMouse>
noremap! <S-Insert> <MiddleMouse>

" n is always search forwward and N is always search backward"{{{
""  -> vim-anzu
" nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
" nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
" vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
" vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
" onoremap <expr> n <SID>search_forward_p() ? 'n' : 'N'
" onoremap <expr> N <SID>search_forward_p() ? 'N' : 'n'
" function! s:search_forward_p() "{{{
"   return exists('v:searchforward') ? v:searchforward : 1
" endfunction "}}}
"}}}

"" Autocompletion using the TAB and SPACE key
"" TAB key is <C-N>
inoremap <tab> <c-r>=InsertTabWrapper()<CR>
"" S-TAB key is <C-P>
inoremap <S-tab> <c-r>=InsertTabWrapper2()<CR>
"" <Space> key is <C-Y>
inoremap <Space> <c-r>=InsertSpaceWrapper()<cr>
""<S-Space> key is <C-E>
inoremap <S-Space> <c-r>=InsertSpaceWrapper2()<cr>
function! InsertTabWrapper() "{{{
  let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<TAB>"
    else
      if pumvisible()
        return "\<C-N>"
      else
        return "\<C-N>\<C-P>"
      end
    endif
endfunction "}}}
function! InsertTabWrapper2() "{{{
  let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<S-TAB>"
    else
      if pumvisible()
        return "\<C-P>"
      else
        return "\<C-N>\<C-P>"
      end
    endif
endfunction "}}}
function! InsertSpaceWrapper() "{{{
  let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<Space>"
    else
      if pumvisible()
        return "\<C-Y>"
      else
        return "\<Space>"
      end
    endif
endfunction "}}}
function! InsertSpaceWrapper2() "{{{
  let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<S-Space>"
    else
      if pumvisible()
        return "\<C-E>"
      else
        return "\<S-Space>"
      end
    endif
endfunction "}}}

"" Quick escape
autocmd MyAutoCmd FileType help nnoremap <buffer> q <C-w>c
autocmd MyAutoCmd FileType help nnoremap <buffer> <ESC><ESC> <C-w>c
" autocmd MyAutoCmd CmdwinEnter * nnoremap <buffer> q <C-\><C-N>
" autocmd MyAutoCmd CmdwinEnter * nnoremap <buffer> <ESC><ESC> <C-\><C-N>

"" Command line buffer.
autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin() "{{{
  nnoremap <buffer><silent> q :<C-u>quit<CR>
  inoremap <buffer><silent> jj :<C-u>quit<CR>
  inoremap <buffer><silent> qq :<C-u>quit<CR>
  inoremap <buffer><silent> hh :<C-u>echo "hallo"<CR>
  nnoremap <Enter> <CR>
  " nnoremap <buffer><silent> <TAB> :<C-u>quit<CR>
  startinsert!
endfunction "}}}

"" Other
nnoremap <F4> :<C-u>colorscheme
"" Get of highlight information at the cursor
"" get command -> :SyntaxInfo
nnoremap <silent> <F5>     :<C-u>SyntaxInfo<CR>
command! SyntaxInfo call s:get_syn_info()
function! s:get_syn_id(transparent) "{{{
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction "}}}
function! s:get_syn_attr(synid) "{{{
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
    \ "name": name,
    \ "ctermfg": ctermfg,
    \ "ctermbg": ctermbg,
    \ "guifg": guifg,
    \ "guibg": guibg}
endfunction "}}}
function! s:get_syn_info() "{{{
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
    \ " ctermfg: " . baseSyn.ctermfg .
    \ " ctermbg: " . baseSyn.ctermbg .
    \ " guifg: " . baseSyn.guifg .
    \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
    \ " ctermfg: " . linkedSyn.ctermfg .
    \ " ctermbg: " . linkedSyn.ctermbg .
    \ " guifg: " . linkedSyn.guifg .
    \ " guibg: " . linkedSyn.guibg
endfunction "}}}

nnoremap <silent><F8> :<C-u>call <SID>ToggleFoldcolumn()<CR>
function! s:ToggleFoldcolumn() "{{{
  if (&foldcolumn==0)
    setlocal foldcolumn=5
  else
    setlocal foldcolumn=0
  endif
endfunction "}}}
nnoremap <silent><F9> :<C-u>call <SID>FoldMarker()<CR>
function! s:FoldMarker() "{{{
  let method=&foldmethod
  if method=='marker'
    setlocal foldmethod=manual
    setlocal foldmethod
  else
    setlocal foldmethod=marker
    setlocal foldmethod
    setlocal foldcolumn=5
  endif
endfunction "}}}

""-test-----------------------------------------------------------------""
xnoremap * <S-i><C-r>*<ESC>
""----------------------------------------------------------------------""
""}}}
""----------------------------------------------------------------------""
"" Commands {{{
" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap
""}}}
""----------------------------------------------------------------------""
"" CUI {{{
"" syntax on
set t_Co=256
if !exists('g:colors_name')
  execute 'colorscheme' globpath(&runtimepath,
        \ 'colors/mycolor.vim') != '' ? 'mycolor' : 'desert'
endif
""}}}
""----------------------------------------------------------------------""
"" GUI {{{
if has('gui_running')
  "" Visual mode select is yank "* register
  "" Yank is other application.
  set guioptions+=a
  "" Menu bar is not present
  set guioptions-=m
  "" Uninclude Toolbar
  set guioptions-=T
  "" No Right-hand scrollbar
  set guioptions-=r
  set guioptions-=R
  "" No Left-hand scrollbar
  set guioptions-=l
  set guioptions-=L
  "" No Bottom (horizonral) scrollbar
  set guioptions-=b
  "" No Cursor Flashing
  set guicursor=a:blinkon0
  "" Don't override colorscheme.
  if !exists('g:colors_name')
    execute 'colorscheme' globpath
          \ (&runtimepath,'colors/mycolor.vim') != '' ? 'mycolor' : 'desert'
  endif

  if has('win32') || has('win64')
    "" Toggle font setting.
    command! TransparencyToggle let &transparency =
          \ (&transparency != 255 && &transparency != 0)? 255 : 221
    nnoremap TT     :<C-u>TransparencyToggle<CR>
    " autocmd MyAutoCmd FocusGained * set transparency=255
    " autocmd MyAutoCmd FocusLost * set transparency=150
  endif

  "" set font
  if s:is_windows
    set gfn=Ricty_for_Powerline:h13:b
    set gfw=Ricty_for_Powerline:h13:b
    "colorscheme mycolor
  else
    set gfn=Ricty\ for\ Powerline\ Bold\ 12
    set gfw=Ricty\ for\ Powerline\ Bold\ 12
  endif

  " Don't focus the window when the mouse pointer is moved.
  set nomousefocus
  " Hide mouse pointer on insert mode.
  set mousehide
endif
""}}}
""----------------------------------------------------------------------""
"" Tips {{{
""
"" Vim Training
"" :q vimtutor

"" Check Key map command
":verb map

"" Operator
"y       yank     copy
"d       delete   delete
"c       change   change
"g       go       moving cursor

"[R] is replace yank
" yy  -> RR  line replace
" yiw -> riw word replace

"" vim command
"g; or g,  move last change point

"" VimFiler
"
"t       directory tree open/close toggle

"" Unite
" bookmark file
" ~/.cache/unite/bookmark/

"" Vim Training
"" :q vimtutor

"" Operator
"y       yank     copy
"d       delete   delete
"c       change   change
"g       go       moving cursor

"" vim-operator-surround
" saw(     test   -> (test)
" sd(      (test) -> test
" sc([     (test) -> [test]

"Fontzoom! <- font size reset

"" tcomment_vim
" gc  <- comment out

"" Gui
" gui font check
"set guifont=*

"" Remove trailing spaces
":%s/ *$//g

"" Visual mode
"gyoumatumade ikkatu senntaku
"<C-v> -> $

"" VimFiler
"
"t       directory tree open/close toggle

"" Unite
" bookmark file
" ~/.cache/unite/bookmark/
""}}}
""----------------------------------------------------------------------""
"" Local Folds setting {{{
""
" vim: foldmethod=marker
" vim: foldcolumn=5
" vim: foldlevel=0

""}}}
