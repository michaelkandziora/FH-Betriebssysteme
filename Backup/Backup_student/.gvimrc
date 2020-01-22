"===================================================================================
"         FILE:  .gvimrc
"  DESCRIPTION:  
"       AUTHOR:  Dr.-Ing. Fritz Mehner
"        EMAIL:  mehner@fh-swf.de
"      COMPANY:  FH Südwestfalen, Iserlohn
"      VERSION:  1.2
"      CREATED:  02.04.2005 - 17:30:25
"     REVISION:  08.07.2009
"===================================================================================
"
set cmdheight=2                       " Make command line two lines high
set mousehide                         " Hide the mouse when typing text

highlight Normal   guibg=grey90
highlight Cursor   guibg=Blue   guifg=NONE
highlight lCursor  guibg=Cyan   guifg=NONE
highlight NonText  guibg=grey80
highlight Constant gui=NONE     guibg=grey95
highlight Special  gui=NONE     guibg=grey95

let c_comment_strings=1               " highlight strings inside C comments
"
"-------------------------------------------------------------------------------
" Moving cursor to other windows:
" shift down   : change window focus to lower one (cyclic)
" shift up     : change window focus to upper one (cyclic)
" shift left   : change window focus to one on left
" shift right  : change window focus to one on right
"-------------------------------------------------------------------------------
nnoremap <s-down>   <c-w>w
nnoremap <s-up>     <c-w>W
nnoremap <s-left>   <c-w>h
nnoremap <s-right>  <c-w>l
"
"-------------------------------------------------------------------------------
"  plugin mru.vim (Yegappan Lakshmanan)
"   Shift-F3  -  open list of recently used files
"-------------------------------------------------------------------------------
 noremap  <silent> <s-F3>       :MRU<CR>
inoremap  <silent> <s-F3>  <Esc>:MRU<CR>
"
"-------------------------------------------------------------------------------
" toggle insert mode <--> 'normal mode with the <RightMouse>-key
"-------------------------------------------------------------------------------
nnoremap  <RightMouse> <Insert>
inoremap  <RightMouse> <ESC>
"
"-------------------------------------------------------------------------------
" use font with clearly distinguishable brackets : ()[]{}
"-------------------------------------------------------------------------------
set guifont=xos4\ Terminus\ 16
set guifont=Luxi\ Mono\ 14
"
"
if has("gui_gtk") || has("gui_gtk2")
  set toolbariconsize=medium
endif

