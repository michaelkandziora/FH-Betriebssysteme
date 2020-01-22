" Vim compiler file
"    Compiler:	Lua Interpreter lua
"  Maintainer:	Fritz Mehner <mehner@fh-swf.de>
"     Version:	$Id$

if exists("current_compiler")
  finish
endif
let current_compiler = "lua"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=lua\ %

CompilerSet errorformat=
		\lua:\ %f:%l:%m,
		\lua:%m

let &cpo = s:cpo_save
unlet s:cpo_save
