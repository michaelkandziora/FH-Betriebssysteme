"===============================================================================
"
"          File:  bashhelp.vim
" 
"   Description:  Vim syntax file / plugin bash-support
" 
"   VIM Version:  7.0+
"        Author:  Dr. Fritz Mehner (fgm), mehner.fritz@fh-swf.de
"  Organization:  FH Südwestfalen, Iserlohn
"       Version:  1.0
"       Created:  23.10.2012 08:59
"      Revision:  ---
"       License:  Copyright (c) 2012, Dr. Fritz Mehner
"===============================================================================
"
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let b:current_syntax = "bashhelp"

" builtins
syn match Statement  "^\(\w\+\):\s\+\1.*$"
" options
syn match Comment	   "^\s*\zs\(--\|[-+]\w\=\)"

