" Vim compiler file
"    Compiler:	Lua Compiler luac
"  Maintainer:	Fritz Mehner <mehner@fh-swf.de>
"     Version:	$Id$

if exists("current_compiler")
  finish
endif
let current_compiler = "luac"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=luac\ %

CompilerSet errorformat=
		\luac:\ %f:%l:%m,
		\luac:%m

let &cpo = s:cpo_save
unlet s:cpo_save
