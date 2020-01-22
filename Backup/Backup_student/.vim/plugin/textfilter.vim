"===================================================================================
"
"         FILE:  textfilter.vim
"
"  DESCRIPTION:  Several text filters (most based on some GNU core utilities).
"
" DEPENDENCIES:
"                column    -  columnate lists
"                env       -  run a program in a modified environment (LANG=C)
"                nl        -  number lines of files
"                printf    -  format and print data
"                seq       -  print a sequence of numbers
"                sort      -  sort lines of text files
"                xargs     -  build and execute command lines from standard input
"
"       AUTHOR:  Dr.-Ing. Fritz Mehner
"        EMAIL:  mehner@fh-swf.de
"      COMPANY:  Fachhochschule Südwestfalen, Iserlohn
"      VERSION:  see variable  g:TextfilterVersion  below
"      CREATED:  29.07.2004 - 18:32:34
"     REVISION:  $Id: textfilter.vim,v 1.6 2009/06/04 15:32:51 mehner Exp $
"      LICENSE:  Copyright (c) 2004-2009, Fritz Mehner
"                This program is free software; you can redistribute it and/or
"                modify it under the terms of the GNU General Public License as
"                published by the Free Software Foundation, version 2 of the
"                License.
"                This program is distributed in the hope that it will be
"                useful, but WITHOUT ANY WARRANTY; without even the implied
"                warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
"                PURPOSE.
"                See the GNU General Public License version 2 for more details.
"
"===================================================================================
"
" Prevent duplicate loading:
"
if exists("g:TextfilterVersion") || &cp
 finish
endif
let g:TextfilterVersion= "1.16"             " version number of this script; do not change
"

"------------------------------------------------------------------------------
"  Defaults
"------------------------------------------------------------------------------
let s:Filter_Escape            = '\\'             " Linux: '\\' ; Dos/Windows: '%'
let s:Filter_NlLeadingZeros    = 'yes'            " toggle default
let s:Filter_RootMenu          = 'F&ilter.'       " name of the root menu (not empty)
let s:Filter_SortAlpha         = 'yes'            " toggle default
let s:Filter_SortForward       = 'yes'            " toggle default
let s:Filter_SortNotUnique     = 'yes'            " toggle default
let s:Filter_LoadMenus         = 'yes'            " toggle default
let s:Filter_LocaleEnv         = substitute( $LANG, '\.', '\\\.', 'g' )
let s:Filter_TimestampFormat   = '%y%m%d.%H%M%S'
let s:Filter_HighlightAfterCol = '80'
let s:Filter_a2psOptions       = '--silent --chars-per-line=92 --portrait --borders 0 --columns=1'
"
let s:Filter_FormatDate           = '%x'
let s:Filter_FormatTime           = '%X'
"
if s:Filter_LocaleEnv != ""
  let s:Filter_Locale       = "yes"
else
  let s:Filter_Locale       = "no"
endif
"
"------------------------------------------------------------------------------
"  Look for global variables (if any), to override some defaults.
"------------------------------------------------------------------------------
function! FilterCheckGlobal ( name )
  if exists('g:'.a:name)
    exe 'let s:'.a:name.'  = g:'.a:name
  endif
endfunction
"
call FilterCheckGlobal("Filter_Escape           ")
call FilterCheckGlobal("Filter_FormatDate       ")
call FilterCheckGlobal("Filter_FormatTime       ")  
call FilterCheckGlobal("Filter_HighlightAfterCol")
call FilterCheckGlobal("Filter_LoadMenus        ")
call FilterCheckGlobal("Filter_RootMenu         ")
call FilterCheckGlobal("Filter_TimestampFormat  ")
call FilterCheckGlobal("Filter_a2psOptions      ")
"
if s:Filter_RootMenu == ""
  let s:Filter_RootMenu = 'F&ilter.'       " use the default
endif
"
" characters that must be escaped for filenames
"
let s:escfilename = ' \%#[]'
"
"===================================================================================
" MENUS
"===================================================================================
"
function! Filter_InitMenu ()
  "
  " -----  sort lines of text files  -------------------------
  "
  exe "amenu  <silent> .100 ".s:Filter_RootMenu."&sort\\ lines\\              :call FilterSort('a')<CR>"
  exe "imenu  <silent> .100 ".s:Filter_RootMenu."&sort\\ lines\\         <Esc>:call FilterSort('a')<CR>i"
  exe "vmenu  <silent> .100 ".s:Filter_RootMenu."&sort\\ lines\\         <Esc>:call FilterSort('v')<CR>"
  "
  if s:Filter_SortForward=='yes'
    exe "amenu  <silent> .105 ".s:Filter_RootMenu."-\\ &forward->reverse       :call FilterSortForwardsToggle()<CR>"
    exe "imenu  <silent> .105 ".s:Filter_RootMenu."-\\ &forward->reverse  <Esc>:call FilterSortForwardsToggle()<CR>i"
    exe "vmenu  <silent> .105 ".s:Filter_RootMenu."-\\ &forward->reverse  <Esc>:call FilterSortForwardsToggle()<CR>gv"
  else
    exe "amenu  <silent> .105 ".s:Filter_RootMenu."-\\ reverse->&forward       :call FilterSortForwardsToggle()<CR>"
    exe "imenu  <silent> .105 ".s:Filter_RootMenu."-\\ reverse->&forward  <Esc>:call FilterSortForwardsToggle()<CR>i"
    exe "vmenu  <silent> .105 ".s:Filter_RootMenu."-\\ reverse->&forward  <Esc>:call FilterSortForwardsToggle()<CR>gv"
  endif
  "
  if s:Filter_SortAlpha=='yes'
    exe "amenu  <silent> .110 ".s:Filter_RootMenu."-\\ &alpha->numeric          :call FilterSortNumericToggle()<CR>"
    exe "imenu  <silent> .110 ".s:Filter_RootMenu."-\\ &alpha->numeric     <Esc>:call FilterSortNumericToggle()<CR>i"
    exe "vmenu  <silent> .110 ".s:Filter_RootMenu."-\\ &alpha->numeric     <Esc>:call FilterSortNumericToggle()<CR>gv"
  else
    exe "amenu  <silent> .110 ".s:Filter_RootMenu."-\\ numeric->&alpha          :call FilterSortNumericToggle()<CR>"
    exe "imenu  <silent> .110 ".s:Filter_RootMenu."-\\ numeric->&alpha     <Esc>:call FilterSortNumericToggle()<CR>"
    exe "vmenu  <silent> .110 ".s:Filter_RootMenu."-\\ numeric->&alpha     <Esc>:call FilterSortNumericToggle()<CR>gv"
  endif
  "
  if s:Filter_SortNotUnique=='yes'
    exe "amenu  <silent> .115 ".s:Filter_RootMenu."-\\ not\\ unique->&unique        :call FilterSortUniqToggle()<CR>"
    exe "imenu  <silent> .115 ".s:Filter_RootMenu."-\\ not\\ unique->&unique   <Esc>:call FilterSortUniqToggle()<CR>i"
    exe "vmenu  <silent> .115 ".s:Filter_RootMenu."-\\ not\\ unique->&unique   <Esc>:call FilterSortUniqToggle()<CR>gv"
  else
    exe "amenu  <silent> .115 ".s:Filter_RootMenu."-\\ &unique->not\\ unique        :call FilterSortUniqToggle()<CR>"
    exe "imenu  <silent> .115 ".s:Filter_RootMenu."-\\ &unique->not\\ unique   <Esc>:call FilterSortUniqToggle()<CR>i"
    exe "vmenu  <silent> .115 ".s:Filter_RootMenu."-\\ &unique->not\\ unique   <Esc>:call FilterSortUniqToggle()<CR>gv"
  endif
  "
  if s:Filter_LocaleEnv != ""
    if s:Filter_Locale=="no"
      exe "amenu  <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ 'C'->'".s:Filter_LocaleEnv."'        :call FilterLocaleToggle()<CR>"
      exe "imenu  <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ 'C'->'".s:Filter_LocaleEnv."'   <Esc>:call FilterLocaleToggle()<CR>i"
      exe "vmenu  <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ 'C'->'".s:Filter_LocaleEnv."'   <Esc>:call FilterLocaleToggle()<CR>gv"
    else
      exe "amenu  <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ '".s:Filter_LocaleEnv."'->'C'        :call FilterLocaleToggle()<CR>"
      exe "imenu  <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ '".s:Filter_LocaleEnv."'->'C'   <Esc>:call FilterLocaleToggle()<CR>i"
      exe "vmenu  <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ '".s:Filter_LocaleEnv."'->'C'   <Esc>:call FilterLocaleToggle()<CR>gv"
    endif
  endif
  "
  exe "amenu  <silent>  .120  ".s:Filter_RootMenu."-SEP0-            :"
  "
  " -----  number lines  -------------------------
  "
  exe "amenu <silent>  .205  ".s:Filter_RootMenu."&number\\ lines         :call FilterNumberLines('a')<CR>"
  exe "imenu <silent>  .205  ".s:Filter_RootMenu."&number\\ lines    <Esc>:call FilterNumberLines('a')<CR>i"
  exe "vmenu <silent>  .205  ".s:Filter_RootMenu."&number\\ lines    <Esc>:call FilterNumberLines('v')<CR>"
  "
  if s:Filter_NlLeadingZeros=='yes'
    exe "amenu <silent> .205 ".s:Filter_RootMenu."-\\ lead\\.&zeros->no\\ lead\\.zeros        :call FilterNlZeroToggle()<CR>"
    exe "imenu <silent> .205 ".s:Filter_RootMenu."-\\ lead\\.&zeros->no\\ lead\\.zeros   <Esc>:call FilterNlZeroToggle()<CR>i"
    exe "vmenu <silent> .205 ".s:Filter_RootMenu."-\\ lead\\.&zeros->no\\ lead\\.zeros   <Esc>:call FilterNlZeroToggle()<CR>gv"
  else
    exe "amenu <silent> .205 ".s:Filter_RootMenu."-no\\ \\ lead\\.zeros->lead\\.&zeros        :call FilterNlZeroToggle()<CR>"
    exe "imenu <silent> .205 ".s:Filter_RootMenu."-no\\ \\ lead\\.zeros->lead\\.&zeros   <Esc>:call FilterNlZeroToggle()<CR>i"
    exe "vmenu <silent> .205 ".s:Filter_RootMenu."-no\\ \\ lead\\.zeros->lead\\.&zeros   <Esc>:call FilterNlZeroToggle()<CR>gv"
  endif
  "
  exe "amenu <silent> .207 ".s:Filter_RootMenu."-\\ number\\ &width       :call FilterNlWidth()<CR>"
  exe "imenu <silent> .207 ".s:Filter_RootMenu."-\\ number\\ &width  <Esc>:call FilterNlWidth()<CR>i"
  exe "vmenu <silent> .207 ".s:Filter_RootMenu."-\\ number\\ &width  <Esc>:call FilterNlWidth()<CR>gv"
  "
  exe "amenu <silent>  .210 ".s:Filter_RootMenu."-SEP1-              :"
  "
  " -----  columnate lists  -------------------------
  "
  exe "amenu <silent> .300 ".s:Filter_RootMenu."&columnate\\ list         :call FilterColumnateLists('a')<CR>"
  exe "imenu <silent> .300 ".s:Filter_RootMenu."&columnate\\ list    <Esc>:call FilterColumnateLists('a')<CR>i"
  exe "vmenu <silent> .300 ".s:Filter_RootMenu."&columnate\\ list    <Esc>:call FilterColumnateLists('v')<CR>"
  "
  exe "amenu <silent> .305 ".s:Filter_RootMenu."-\\ s&eparator            :call FilterColumnateSep()<CR>"
  exe "imenu <silent> .305 ".s:Filter_RootMenu."-\\ s&eparator       <Esc>:call FilterColumnateSep()<CR>i"
  exe "vmenu <silent> .305 ".s:Filter_RootMenu."-\\ s&eparator       <Esc>:call FilterColumnateSep()<CR>gv"
  "
  exe "amenu <silent>  .310 ".s:Filter_RootMenu."-SEP2-              :"
  "
  " -----  expand  :  tabs -> spaces  -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."&tabs\\ to\\ spaces            :call FilterExpand('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."&tabs\\ to\\ spaces       <Esc>:call FilterExpand('a')<CR>i"
  exe "vmenu <silent> ".s:Filter_RootMenu."&tabs\\ to\\ spaces       <Esc>:call FilterExpand('v')<CR>"
  "
  " -----  unexpand  :  spaces -> tabs  -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."s&paces\\ to\\ tabs            :call FilterUnexpand('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."s&paces\\ to\\ tabs       <Esc>:call FilterUnexpand('a')<CR>i"
  exe "vmenu <silent> ".s:Filter_RootMenu."s&paces\\ to\\ tabs       <Esc>:call FilterUnexpand('v')<CR>"
  "
  exe "amenu <silent>  ".s:Filter_RootMenu."-SEP3-              :"
  "
  " -----  compress empty lines  --------------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."compress\\ empt&y\\ lines      :call FilterCompressEmptyLines('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."compress\\ empt&y\\ lines <Esc>:call FilterCompressEmptyLines('a')<CR>i"
  exe "vmenu <silent> ".s:Filter_RootMenu."compress\\ empt&y\\ lines <Esc>:call FilterCompressEmptyLines('v')<CR>"
  "
  exe "amenu <silent>  ".s:Filter_RootMenu."-SEP4-              :"
  "
  " -----  fill lines to equal length with blanks  -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."f&ill\\ lines\\ (spaces)       :call FilterMultiLineEndFill('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."f&ill\\ lines\\ (spaces)  <Esc>:call FilterMultiLineEndFill('a')<CR>i"
  exe "vmenu <silent> ".s:Filter_RootMenu."f&ill\\ lines\\ (spaces)  <Esc>:call FilterMultiLineEndFill('v')<CR>"
  "
  " -----  trim trailing spaces  -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."tri&m\\ trail\\.\\ whitespaces        :call FilterMultiLineTrim('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."tri&m\\ trail\\.\\ whitespaces   <Esc>:call FilterMultiLineTrim('a')<CR>i"
  exe "vmenu <silent> ".s:Filter_RootMenu."tri&m\\ trail\\.\\ whitespaces   <Esc>:call FilterMultiLineTrim('v')<CR>"
  "
  exe "amenu <silent>  ".s:Filter_RootMenu."-SEP5-              :"
  "
  " -----  left justify lines  -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."&left\\ justify         :call FilterLeftJustify('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."&left\\ justify    <Esc>:call FilterLeftJustify('a')<CR>i"
  exe "vmenu <silent> ".s:Filter_RootMenu."&left\\ justify    <Esc>:call FilterLeftJustify('v')<CR>"
  "
  " -----  right justify lines  -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."&right\\ justify        :call FilterRightJustify('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."&right\\ justify   <Esc>:call FilterRightJustify('a')<CR>i"
  exe "vmenu <silent> ".s:Filter_RootMenu."&right\\ justify   <Esc>:call FilterRightJustify('v')<CR>"
  "
  exe "amenu <silent>  ".s:Filter_RootMenu."-SEP6-              :"
  "
  " -----  split lines  -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."split\\ lines\\ \\ (&1)        :call FilterSplitLines('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."split\\ lines\\ \\ (&1)   <Esc>:call FilterSplitLines('a')<CR>"
  exe "vmenu <silent> ".s:Filter_RootMenu."split\\ lines\\ \\ (&1)   <Esc>:call FilterSplitLines('v')<CR>"
  "
  exe "amenu <silent>  ".s:Filter_RootMenu."-\\ split\\ separator\\ \\ (&2)            :call FilterSplitSep()<CR>"
  exe "imenu <silent>  ".s:Filter_RootMenu."-\\ split\\ separator\\ \\ (&2)       <Esc>:call FilterSplitSep()<CR>i"
  exe "vmenu <silent>  ".s:Filter_RootMenu."-\\ split\\ separator\\ \\ (&2)       <Esc>:call FilterSplitSep()<CR>gv"
  "
  exe "amenu <silent>  ".s:Filter_RootMenu."-SEP7-              :"
  "
  " -----  sequence of numbers  -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."se&quence\\ of\\ numbers       :call FilterSeqOfNum()<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."se&quence\\ of\\ numbers  <Esc>:call FilterSeqOfNum()<CR>i"
  "
  exe "amenu <silent>  ".s:Filter_RootMenu."-SEP8-              :"
  "
  " -----  hardcopy with a2ps  --------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu.'hardcopy\ (a2ps)       :exe Hardcopy()<CR>'
  exe "imenu <silent> ".s:Filter_RootMenu.'hardcopy\ (a2ps)  <Esc>:exe Hardcopy()<CR>i'
  "
  " -----  save buffer with time stamp  -----------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu.'save\ &buffer\ with\ time\ stamp        :call FilterSaveWithTimestamp()<CR>'
  exe "imenu <silent> ".s:Filter_RootMenu.'save\ &buffer\ with\ time\ stamp   <Esc>:call FilterSaveWithTimestamp()<CR>i'
  "
  " -----  find longest line    -------------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu."find\\ lon&gest\\ line       :call FilterLongestLine('a')<CR>"
  exe "imenu <silent> ".s:Filter_RootMenu."find\\ lon&gest\\ line  <Esc>:call FilterLongestLine('a')<CR>i"
  exe "vmenu <silent> ".s:Filter_RootMenu."find\\ lon&gest\\ line  <Esc>:call FilterLongestLine('v')<CR>"
  "
  " -----  highlight after column n    ------------------
  "
  exe "amenu <silent> ".s:Filter_RootMenu.'highlight\ after\ column\ n       :exe FilterHighlightColumn()<CR>'
  exe "imenu <silent> ".s:Filter_RootMenu.'highlight\ after\ column\ n  <Esc>:exe FilterHighlightColumn()<CR>i'
  "
  " -----  date and time  -------------------------------
  "
  exe "amenu  <silent>  ".s:Filter_RootMenu."-SEP9-            :"
  "
  exe "amenu  <silent>  ".s:Filter_RootMenu.'&date          <Esc>:call Filter_InsertDateAndTime("dn" )<CR>'
  exe "imenu  <silent>  ".s:Filter_RootMenu.'&date          <Esc>:call Filter_InsertDateAndTime("d"  )<CR>a'
  exe "vmenu  <silent>  ".s:Filter_RootMenu.'&date         s<Esc>:call Filter_InsertDateAndTime("d"  )<CR>a'
  exe "amenu  <silent>  ".s:Filter_RootMenu.'date\ &time    <Esc>:call Filter_InsertDateAndTime("dtn")<CR>'
  exe "imenu  <silent>  ".s:Filter_RootMenu.'date\ &time    <Esc>:call Filter_InsertDateAndTime("dt" )<CR>a'
  exe "vmenu  <silent>  ".s:Filter_RootMenu.'date\ &time   s<Esc>:call Filter_InsertDateAndTime("dt" )<CR>a'
  "
endfunction    " ----- Filter_InitMenu -----
"
"===================================================================================
" FUNCTIONS
"===================================================================================
"
"------------------------------------------------------------------------------
"  Insert escape sequences
"------------------------------------------------------------------------------
function! FilterInsEscape ( inputstring )
  let result   = substitute( a:inputstring, '%', s:Filter_Escape.'%', 'g' )
  let result   = substitute(        result, '#', s:Filter_Escape.'#', 'g' )
  return result
endfunction    " ----- FilterInsEscape -----
"
"------------------------------------------------------------------------------
"  Input after a highlighted prompt
"------------------------------------------------------------------------------
function! FilterInput ( prompt, text )
  echohl Search                        " highlight prompt
  call inputsave()                     " preserve typeahead
  let retval=input( a:prompt, a:text ) " read input
  call inputrestore()                  " restore typeahead
  echohl None                          " reset highlighting
  return retval
endfunction    " ----- FilterInput -----
"
"------------------------------------------------------------------------------
"  FilterExpand
"  Expand tabs to spaces
"------------------------------------------------------------------------------
function! FilterExpand ( arg )
  let save_expandtab  = &expandtab
  exe ":set expandtab"
  "
  if a:arg=='a'
    if winheight(0) < line("$")
      let name  = FilterInput("expand whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
    let cursorposition  = line(".")
     exe ":%retab"
    exe cursorposition
  endif
  "
  if a:arg=='v'
     exe ":'<,'>retab"
  endif
  let &expandtab  = save_expandtab
endfunction    " ----- FilterExpand -----
"
"------------------------------------------------------------------------------
"  FilterUnexpand
"  Unexpand : spaces to tabs
"------------------------------------------------------------------------------
function! FilterUnexpand ( arg )
  let save_expandtab  = &expandtab
  exe ":set noexpandtab"
  "
  if a:arg=='a'
    if winheight(0) < line("$")
      let name  = FilterInput("unexpand whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
    let cursorposition  = line(".")
     exe ":%retab!"
    exe cursorposition
  endif
  "
  if a:arg=='v'
     exe ":'<,'>retab!"
  endif
  let &expandtab  = save_expandtab
endfunction    " ----- FilterUnexpand -----
"
"------------------------------------------------------------------------------
"  sequence of numbers
"  Return an empty string to reset to the default command
"------------------------------------------------------------------------------
let s:Filter_SeqOfNumCmd=""                               " the last command

function! FilterSeqOfNum ()
  "
  if !( executable("env") && executable("xargs") && executable("printf") )
    echomsg "utility 'env' or 'printf' or 'xargs' not executable"
    return
  endif
  "
  let prmptdef  = ' 1  1  10  "%02d\n"'
  if s:Filter_SeqOfNumCmd==""
    let s:Filter_SeqOfNumCmd=prmptdef                     " restore default
  endif
  let s:Filter_SeqOfNumCmd  = FilterInput( " FIRST INC LAST FORMAT : ", s:Filter_SeqOfNumCmd )
  "
  " escape some characters to avoid getting expanded by the Vim command-line processor
  "
  let cmd   = FilterInsEscape( s:Filter_SeqOfNumCmd )
  "
  let part1 = strpart( cmd, 0, match( cmd, "\"" ) )
  let part2 = strpart( cmd, match( cmd, "\"" ) )
  if cmd != ""
    :execute 'r! env LANG=C seq '.part1.' | env LANG=C xargs printf '.part2
  endif
endfunction    " ----- FilterSeqOfNum -----
"
"------------------------------------------------------------------------------
"  Number lines : input number width
"------------------------------------------------------------------------------
let s:Filter_NlWidth  = 0     " 0 = auto
"
function! FilterNlWidth( )
  let newval = FilterInput("number width [0=auto] : ", s:Filter_NlWidth )
  if newval =~ "^\\d\\+$"
    let s:Filter_NlWidth  = newval
  endif
endfunction    " ----- FilterNlWidth -----
"
"------------------------------------------------------------------------------
"  Number lines : generate numbers
"------------------------------------------------------------------------------
function! FilterNumberLines ( arg )
  "
  if !executable("nl")
    echomsg "utility 'nl' is not executable"
    return
  endif
  "
  let nl_options = " --number-separator=' ' --number-format=rn"
  if s:Filter_NlLeadingZeros=='yes'
    let nl_options = " --number-separator=' ' --number-format=rz"
  endif
  if a:arg=='a'
    if winheight(0) < line("$")
      let name  = FilterInput("number whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
    let pos0           = 1
    let pos1           = line("$")
    let cursorposition = line(".")
  endif
  if a:arg=='v'
    let pos0           = line("'<'")
    let pos1           = line("'>'")
    let cursorposition = pos0
  endif
  if s:Filter_NlWidth == "0"
    let nl_options = nl_options." --number-width=".strlen(pos1-pos0+1)
  else
    let nl_options = nl_options." --number-width=".s:Filter_NlWidth
  endif
  exe ":".pos0.",".pos1."!nl -ba".nl_options
  exe cursorposition
endfunction    " ----- FilterNumberLines -----
"
"------------------------------------------------------------------------------
"  COLUMNATE LISTS
"------------------------------------------------------------------------------
let s:Filter_ColumnateSeparator=""

"------------------------------------------------------------------------------
"  FilterColumnateSep
"  Read separator
"------------------------------------------------------------------------------
function! FilterColumnateSep ( )
  let s:Filter_ColumnateSeparator  =
  \       FilterInput(" separator : ", s:Filter_ColumnateSeparator )
  exe ":match Search /".s:Filter_ColumnateSeparator."/"
endfunction    " ----- FilterColumnateSep -----

"------------------------------------------------------------------------------
"  FilterColumnateLists
"  Columnate lists
"------------------------------------------------------------------------------
function! FilterColumnateLists ( arg )
  "
  if !executable("column")
    echomsg "utility 'column' is not executable"
    return
  endif
  "
  if a:arg=='a'
    if winheight(0) < line("$")
      let name = FilterInput("columnate whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
    let pos0           = 1
    let pos1           = line("$")
    let cursorposition = line(".")
  endif
  "
  if a:arg=='v'
    let pos0           = line("'<")
    let pos1           = line("'>")
    let cursorposition = pos0
  endif
  "
  let separator   = FilterInsEscape( s:Filter_ColumnateSeparator )
  if s:Filter_ColumnateSeparator==""
    exe ":".pos0.",".pos1." !column -t "
  else
    exe ":".pos0.",".pos1." !column -t -s\"".separator."\""
  endif
  " column uses 2 blanks to separate columns; reduce to one:
  exe ":".pos0.",".pos1.'s/  \(\S\)/ \1/g'
  exe cursorposition
endfunction    " ----- FilterColumnateLists -----
"
"------------------------------------------------------------------------------
"  FilterSort
"------------------------------------------------------------------------------
function! FilterSort( arg )
  "
  if !executable("sort")
    echomsg "utility 'sort' is not executable"
    return
  endif
  "
  let environment=""
  if s:Filter_Locale=="no"
    let environment="env LC_ALL=C "
  endif

  let sort_options=""
  if s:Filter_SortForward=='no'
    let sort_options = " --reverse"
  endif
  if s:Filter_SortAlpha=='no'
    let sort_options = sort_options." --numeric-sort"
  endif
  if s:Filter_SortNotUnique=='no'
    let sort_options = sort_options." --unique"
  endif
  "
  if a:arg=='a'
    if winheight(0) < line("$")
      let name  = FilterInput("sort whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
    exe ":%    !".environment."sort ".sort_options
    normal gg
  endif
  "
  if a:arg=='v'
    "
    " visual mode -- sort lines
    "
    let vmode = visualmode()
    if vmode=='v' || vmode=='V'
      exe ":'<,'>!".environment."sort ".sort_options
    endif
    "
    " visual mode -- sort block
    "
    if vmode== "\<c-v>"
      let pos0       = line("'<")
      let pos1       = line("'>")
      let lcol       = col("'<")
      let rcol       = col("'>")
      if lcol>rcol
        let  lcol = col("'>")
        let  rcol = col("'<")
      endif
      let blockwidth = rcol - lcol + 1
      "
      if lcol==1
        silent exe ":".pos0.",".pos1."s/\\(.\\{".blockwidth."\\}\\)\\(.*\\)/\\1 \\1\\2/"
      else
        let lcol     = lcol-1
        silent exe ":".pos0.",".pos1."s/\\(.\\{1,".lcol."\\}\\)\\(.\\{".blockwidth."\\}\\)\\(.*\\)/\\2 \\1\\2\\3/"
      endif
      "
      exe ":'<,'>!".environment."sort --key=1,1".sort_options
      "
      let blockwidth = blockwidth + 1
      silent exe ":".pos0.",".pos1."s/^.\\{".blockwidth."\\}//"
      "
    endif
  endif
endfunction    " ----- FilterSort -----
"
"------------------------------------------------------------------------------
"  FilterSortForwardsToggle
"  Toggle sort options : forward <-> reverse
"------------------------------------------------------------------------------
function! FilterSortForwardsToggle()
  if s:Filter_SortForward=='yes'
    exe "aunmenu <silent>  .105 ".s:Filter_RootMenu."-\\ &forward->reverse"
    exe "amenu   <silent>  .105 ".s:Filter_RootMenu."-\\ reverse->&forward        :call FilterSortForwardsToggle()<CR>"
    exe "imenu   <silent>  .105 ".s:Filter_RootMenu."-\\ reverse->&forward   <Esc>:call FilterSortForwardsToggle()<CR>i"
    exe "vmenu   <silent>  .105 ".s:Filter_RootMenu."-\\ reverse->&forward   <Esc>:call FilterSortForwardsToggle()<CR>gv"
    let s:Filter_SortForward='no'
  else
    exe "aunmenu <silent>  .105 ".s:Filter_RootMenu."-\\ reverse->&forward"
    exe "amenu   <silent>  .105 ".s:Filter_RootMenu."-\\ &forward->reverse        :call FilterSortForwardsToggle()<CR>"
    exe "imenu   <silent>  .105 ".s:Filter_RootMenu."-\\ &forward->reverse   <Esc>:call FilterSortForwardsToggle()<CR>i"
    exe "vmenu   <silent>  .105 ".s:Filter_RootMenu."-\\ &forward->reverse   <Esc>:call FilterSortForwardsToggle()<CR>gv"
    let s:Filter_SortForward='yes'
  endif
endfunction    " ----- FilterSortForwardsToggle -----
"
"------------------------------------------------------------------------------
"  FilterSortNumericToggle
"  Toggle sort options : alpha <-> numeric
"------------------------------------------------------------------------------
function! FilterSortNumericToggle()
  if s:Filter_SortAlpha=='yes'
    exe "aunmenu <silent> .110 ".s:Filter_RootMenu."-\\ &alpha->numeric"
    exe "amenu   <silent> .110 ".s:Filter_RootMenu."-\\ numeric->&alpha            :call FilterSortNumericToggle()<CR>"
    exe "imenu   <silent> .110 ".s:Filter_RootMenu."-\\ numeric->&alpha       <Esc>:call FilterSortNumericToggle()<CR>i"
    exe "vmenu   <silent> .110 ".s:Filter_RootMenu."-\\ numeric->&alpha       <Esc>:call FilterSortNumericToggle()<CR>gv"
    let s:Filter_SortAlpha='no'
  else
    exe "aunmenu <silent> .110 ".s:Filter_RootMenu."-\\ numeric->&alpha"
    exe "amenu   <silent> .110 ".s:Filter_RootMenu."-\\ &alpha->numeric            :call FilterSortNumericToggle()<CR>"
    exe "imenu   <silent> .110 ".s:Filter_RootMenu."-\\ &alpha->numeric       <Esc>:call FilterSortNumericToggle()<CR>i"
    exe "vmenu   <silent> .110 ".s:Filter_RootMenu."-\\ &alpha->numeric       <Esc>:call FilterSortNumericToggle()<CR>gv"
    let s:Filter_SortAlpha='yes'
  endif
endfunction    " ----- FilterSortNumericToggle -----
"
"------------------------------------------------------------------------------
"  FilterSortUniqToggle
"  Toggle sort options : unique <-> not unique
"------------------------------------------------------------------------------
function! FilterSortUniqToggle()
  if s:Filter_SortNotUnique=='yes'
    exe "aunmenu <silent> .115 ".s:Filter_RootMenu."-\\ not\\ unique->&unique"
    exe "amenu   <silent> .115 ".s:Filter_RootMenu."-\\ &unique->not\\ unique          :call FilterSortUniqToggle()<CR>"
    exe "imenu   <silent> .115 ".s:Filter_RootMenu."-\\ &unique->not\\ unique     <Esc>:call FilterSortUniqToggle()<CR>i"
    exe "vmenu   <silent> .115 ".s:Filter_RootMenu."-\\ &unique->not\\ unique     <Esc>:call FilterSortUniqToggle()<CR>gv"
    let s:Filter_SortNotUnique='no'
  else
    exe "aunmenu <silent> .115 ".s:Filter_RootMenu."-\\ &unique->not\\ unique"
    exe "amenu   <silent> .115 ".s:Filter_RootMenu."-\\ not\\ unique->&unique          :call FilterSortUniqToggle()<CR>"
    exe "imenu   <silent> .115 ".s:Filter_RootMenu."-\\ not\\ unique->&unique     <Esc>:call FilterSortUniqToggle()<CR>i"
    exe "vmenu   <silent> .115 ".s:Filter_RootMenu."-\\ not\\ unique->&unique     <Esc>:call FilterSortUniqToggle()<CR>gv"
    let s:Filter_SortNotUnique='yes'
  endif
endfunction    " ----- FilterSortUniqToggle -----
"
"------------------------------------------------------------------------------
"  FilterLocaleToggle
"  Toggle sort options : unique <-> not unique
"------------------------------------------------------------------------------
function! FilterLocaleToggle()
  if s:Filter_Locale=="no"
    exe "aunmenu <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ 'C'->'".s:Filter_LocaleEnv."'"
    exe "amenu   <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ '".s:Filter_LocaleEnv."'->'C'        :call FilterLocaleToggle()<CR>"
    exe "imenu   <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ '".s:Filter_LocaleEnv."'->'C'   <Esc>:call FilterLocaleToggle()<CR>i"
    exe "vmenu   <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ '".s:Filter_LocaleEnv."'->'C'   <Esc>:call FilterLocaleToggle()<CR>gv"
    let s:Filter_Locale= "yes"
  else
    exe "aunmenu <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ '".s:Filter_LocaleEnv."'->'C'"
    exe "amenu   <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ 'C'->'".s:Filter_LocaleEnv."'        :call FilterLocaleToggle()<CR>"
    exe "imenu   <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ 'C'->'".s:Filter_LocaleEnv."'   <Esc>:call FilterLocaleToggle()<CR>i"
    exe "vmenu   <silent> .117 ".s:Filter_RootMenu."-\\ l&ocale\\ 'C'->'".s:Filter_LocaleEnv."'   <Esc>:call FilterLocaleToggle()<CR>gv"
    let s:Filter_Locale="no"
  endif
endfunction    " ----- FilterLocaleToggle -----
"
"------------------------------------------------------------------------------
"  FilterNlZeroToggle
"  Toggle nl options : leading zeros  <-> no leading zeros
"------------------------------------------------------------------------------
function! FilterNlZeroToggle()
  if s:Filter_NlLeadingZeros=='yes'
    exe "aunmenu<silent> .205 ".s:Filter_RootMenu."-\\ lead\\.&zeros->no\\ lead\\.zeros"
    exe "amenu  <silent> .205 ".s:Filter_RootMenu."-\\ no\\ lead\\.zeros->lead\\.&zeros        :call FilterNlZeroToggle()<CR>"
    exe "imenu  <silent> .205 ".s:Filter_RootMenu."-\\ no\\ lead\\.zeros->lead\\.&zeros   <Esc>:call FilterNlZeroToggle()<CR>i"
    exe "vmenu  <silent> .205 ".s:Filter_RootMenu."-\\ no\\ lead\\.zeros->lead\\.&zeros   <Esc>:call FilterNlZeroToggle()<CR>gv"
    let s:Filter_NlLeadingZeros='no'
  else
    exe "aunmenu<silent> .205 ".s:Filter_RootMenu."-\\ no\\ lead\\.zeros->lead\\.&zeros"
    exe "amenu  <silent> .205 ".s:Filter_RootMenu."-\\ lead\\.&zeros->no\\ lead\\.zeros        :call FilterNlZeroToggle()<CR>"
    exe "imenu  <silent> .205 ".s:Filter_RootMenu."-\\ lead\\.&zeros->no\\ lead\\.zeros   <Esc>:call FilterNlZeroToggle()<CR>i"
    exe "vmenu  <silent> .205 ".s:Filter_RootMenu."-\\ lead\\.&zeros->no\\ lead\\.zeros   <Esc>:call FilterNlZeroToggle()<CR>gv"
    let s:Filter_NlLeadingZeros='yes'
  endif
endfunction    " ----- FilterNlZeroToggle -----
"
"------------------------------------------------------------------------------
"  FilterLongestLineLength
"  Find length of the longest line in a block
"------------------------------------------------------------------------------
function! FilterLongestLineLength ( pos0, pos1 )
  let maxlength   = 0
  let linenumber  = a:pos0
  while linenumber <= a:pos1
    exe ":".linenumber
    let linelength  = virtcol("$")
    if maxlength < linelength
      let maxlength = linelength
    endif
    let linenumber  = linenumber+1
  endwhile
  return maxlength
endfunction    " ----- FilterLongestLineLength -----
"
"------------------------------------------------------------------------------
"  FilterMultiLineEndFill
"  Fill lines with spaces
"------------------------------------------------------------------------------
function! FilterMultiLineEndFill ( arg1 )
  if a:arg1=='a'
    if winheight(0) < line("$")
      let name  = FilterInput("fill whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
    let pos0=1
    let pos1=line("$")
  endif
  if a:arg1=='v'
    let  pos0      =  line("'<")
    let  pos1      =  line("'>")
  endif
  let cursorposition  = line(".")
  "
  " ----- trim whitespaces -----
  exe pos0.','.pos1.'s/\s*$//'
  " ----- find the longest line -----
  let maxlength   = FilterLongestLineLength(pos0,pos1)
  " ----- fill lines with spaces -----
  let linenumber  = pos0
  exe pos0
  while linenumber <= pos1
    let diff = maxlength-virtcol("$")
    if diff>0
      exe "normal ".diff."A "
    endif
    let linenumber=linenumber+1
    normal j
  endwhile
  " ----- back to the beginning of the marked block -----
  exe cursorposition
endfunction    " ----- FilterMultiLineEndFill -----
"
"------------------------------------------------------------------------------
"  Compress empty lines
"------------------------------------------------------------------------------
function! FilterCompressEmptyLines ( arg1 )
  if a:arg1=='a'
    if winheight(0) < line("$")
      let name  = FilterInput("whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
    let pos0=1
    let pos1=line("$")
  endif
  if a:arg1=='v'
    let  pos0      =  line("'<")
    let  pos1      =  line("'>")
  endif
  let cursorposition  = line(".")
  "
  " one line infile
  if pos1-pos0 == 0
    return
  endif
  "
  " two lines infile
  if pos1-pos0 == 1
    silent! exe pos0.','.pos1.'s/^\s*\n\s*$//'
    return
  endif
  exe pos0.','.pos1.'s/^\(\s*\n\)\{2,\}/\r/'
  " special treatment for the last 2 lines:
  " the last line does not terminate with a \n
  if getline(line("$")-1)=="" && getline("$")!~'\S\+'
    exe ":$,$d"
  endif
  " ----- back to the beginning of the marked block -----
  exe cursorposition
endfunction    " ----- FilterCompressEmptyLines -----
"
"------------------------------------------------------------------------------
"  Trim lines
"------------------------------------------------------------------------------
function! FilterMultiLineTrim ( arg1 )
  "
  if a:arg1=='a'
    let pos0 = 1
    let pos1 = line("$")
    if winheight(0) < line("$")
      let name  = FilterInput("trim whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
  endif
  "
  if a:arg1=='v'
    let  pos0 = line("'<")
    let  pos1 = line("'>")
  endif
  "
  let cursorposition  = line(".")
  " ----- trim whitespaces -----
  exe pos0.','.pos1.'s/\s\+$//'
  " ----- back to the beginning of the marked block -----
  exe cursorposition
endfunction    " ----- FilterMultiLineTrim -----

"------------------------------------------------------------------------------
"  FilterSplitSep
"  Read separator
"------------------------------------------------------------------------------
let s:Filter_SplitSeparator='\s\+'

function! FilterSplitSep ( )
  let s:Filter_SplitSeparator  =
  \       FilterInput(" split separator : ", s:Filter_SplitSeparator )
  exe ":match Search /".s:Filter_SplitSeparator."/"
endfunction    " ----- FilterSplitSep -----
"
"------------------------------------------------------------------------------
"  Split lines
"------------------------------------------------------------------------------
function! FilterSplitLines ( arg1 )
  "
  if a:arg1=='a'
    let pos0 = line(".")
    let pos1 = pos0
  endif
  "
  if a:arg1=='v'
    let  pos0 = line("'<")
    let  pos1 = line("'>")
  endif
  "
  let cursorposition  = line(".")
  " ----- split lines -----
  while s:Filter_SplitSeparator==''
    call FilterSplitSep()
  endwhile
  exe pos0.','.pos1.'s/'.s:Filter_SplitSeparator.'/\r/g'
  " ----- back to the beginning of the marked block -----
  exe cursorposition
endfunction    " ----- FilterSplitLines -----
"
"------------------------------------------------------------------------------
"  Left justify
"------------------------------------------------------------------------------
function! FilterLeftJustify ( arg1 )
  let cursorposition  = line(".")
  if a:arg1=='a'
    let pos0 = 1
    let pos1 = line("$")
    if winheight(0) < line("$")
      let name  = FilterInput("left justify whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
  endif
  if a:arg1=='v'
    let  pos0 = line("'<")
    let  pos1 = line("'>")
    let  lcol = virtcol("'<")
    let  rcol = virtcol("'>")
    if lcol>rcol
      let  lcol = virtcol("'>")
      let  rcol = virtcol("'<")
    endif
  endif
  "
  let save_expandtab  = &expandtab
  exe ":set expandtab"
  exe ":".pos0.",".pos1."retab"
  let &expandtab  = save_expandtab
  "
  " ----- left justify block ------------------
  "
  if a:arg1=='v' && visualmode()== "\<c-v>" && lcol<rcol
    let linenumber  = pos0
    exe pos0
    while linenumber <= pos1
      let curline = getline(linenumber)
      if curline =~ '\S\+'           " do not process empty lines
        let head  = strpart( curline, 0, lcol-1 )
        let block = strpart( curline, lcol-1, rcol-lcol+1 )
        let tail  = strpart( curline, rcol )
        let block = substitute( block, '^\(\s*\)\(.*\)', '\2\1' , "" )
        put! =head.block.tail
        normal jddk
      endif
      let linenumber=linenumber+1
      normal j
    endwhile
  "
  " ----- left justify lines ------------------
  "
  else
    exe pos0.','.pos1.'s/^\s*//'
  endif
  " ----- back to the beginning of the marked block -----
  exe cursorposition
endfunction    " ----- FilterLeftJustify -----
"
"------------------------------------------------------------------------------
"  Right justify
"------------------------------------------------------------------------------
function! FilterRightJustify ( arg1 )
  if a:arg1=='a'
    if winheight(0) < line("$")
      let name  = FilterInput("right justify whole file [y/n/Esc] : ", "y" )
      if name != "y"
        return
      endif
    endif
    let pos0=1
    let pos1=line("$")
  endif
  if a:arg1=='v'
    let  pos0 = line("'<")
    let  pos1 = line("'>")
    let  lcol = virtcol("'<")
    let  rcol = virtcol("'>")
    if lcol>rcol
      let  lcol = virtcol("'>")
      let  rcol = virtcol("'<")
    endif
  endif
  let cursorposition  = line(".")
  "
  let save_expandtab  = &expandtab
  exe ":set expandtab"
  exe ":".pos0.",".pos1."retab"
  let &expandtab  = save_expandtab
  "
  " ----- right justify block ------------------
  "
  if a:arg1=='v' && visualmode()== "\<c-v>" && lcol<rcol
    let linenumber  = pos0
    exe pos0
    let blockwidth  = rcol-lcol+1
    while linenumber <= pos1
      let curline = getline( linenumber )
      if curline =~ '\S\+'           " do not process empty lines
        let head    = strpart( curline, 0, lcol-1 )
        let block   = strpart( curline, lcol-1, blockwidth )
        let tail    = strpart( curline, rcol )
        " fill blocks which are to short
        while strlen( block ) < blockwidth
          let block = block.' '
        endwhile
        let block =substitute( block, '\(.\{-}\)\(\s*\)$', '\2\1' , "" )
        put! =head.block.tail
        normal jddk
      endif
      let linenumber=linenumber+1
      normal j
    endwhile
  "
  " ----- right justify lines ------------------
  "
  else
    " ----- trim whitespaces -----
    exe pos0.','.pos1.'s/\s*$//'
    " ----- find the longest line -----
    let maxlength  = FilterLongestLineLength(pos0,pos1)
    let linenumber = pos0
    exe pos0
    while linenumber <= pos1
      let diff = maxlength-virtcol("$")
      " ----- right justify : prepend spaces -----
      if diff>0
        exe "normal ".diff."I "
      endif
      let linenumber=linenumber+1
      normal j
    endwhile
  endif
  " ----- back to the beginning of the marked block -----
  exe cursorposition
endfunction    " ----- FilterRightJustify -----
"
"------------------------------------------------------------------------------
"  Find longest line
"------------------------------------------------------------------------------
function! FilterLongestLine( mode )
  if a:mode=="a"
    let firstline   = line(".")
    let lastline    = line("$")
  endif
  if a:mode=="v"
    let firstline   = line("'<")
    let lastline    = line("'>")
  endif
  let linenumber  = firstline
  let longline    = firstline
  let maxlength   = 0
  while linenumber <= lastline
    exe ":".linenumber
    let vc  = virtcol("$")
    if maxlength == vc
      let equline   = equline+1
    endif
    if maxlength < vc
      let maxlength = vc
      let longline  = linenumber
      let equline   = 0
    endif
    let linenumber  = linenumber+1
  endwhile
  exe ":".longline
  let maxlength = maxlength-1
  redraw
  echohl Search                        " highlight prompt
  echo "range ".firstline."-".lastline." : longest line has number ".longline.", length ".maxlength
        \ ."  (".equline." line(s) of equal length below)"
  echohl None                          " reset highlighting
endfunction    " ----- FilterLongestLine -----
"
"------------------------------------------------------------------------------
"  Highlight after column n
"------------------------------------------------------------------------------
function! FilterHighlightColumn ()
  let prompt  = "highlight after column : "
  if exists("b:FilterHighlightCol")
    let b:FilterHighlightCol= FilterInput( prompt, b:FilterHighlightCol )
  else
    let b:FilterHighlightCol= FilterInput( prompt , s:Filter_HighlightAfterCol )
  endif
  if b:FilterHighlightCol =~ '^\s*\d\+\s*$'
    let b:FilterHighlightCol = substitute( b:FilterHighlightCol, '^\s*', '' , "" )
    let b:FilterHighlightCol = substitute( b:FilterHighlightCol, '\s*$', '' , "" )
    return  '/\%>'.b:FilterHighlightCol.'v.\+$'
  else
    let b:FilterHighlightCol= ""
    return ""
  endif
endfunction   " ---------- end of function  FilterHighlightColumn  ----------
"
"-------------------------------------------------------------------------------
" hardcopy with a2ps
"-------------------------------------------------------------------------------
function! Hardcopy ()
  if ! executable("a2ps")
    echomsg "utility 'a2ps' is not executable"
    return
  endif
  let buffer  = expand("%")
  let cmd = 'a2ps '.s:Filter_a2psOptions.' --output="'.buffer.'.ps" "'.buffer.'"'
  silent exe ":!".cmd
  return
endfunction    " ----------  end of function Hardcopy  ----------
"------------------------------------------------------------------------------
"  Save buffer with time stamp / preserve file extension
"------------------------------------------------------------------------------
function! FilterSaveWithTimestamp ()
  if expand("%") == ""
    redraw
    echohl WarningMsg | echo " no file name " | echohl None
    return
  endif
  let Sou  = escape( expand("%:p:r"), s:escfilename ).".".strftime(s:Filter_TimestampFormat)
  let ext  = expand("%:e")
  if ext != ""
    let Sou   = Sou.".".ext
  endif
  exe ":write ".Sou
  "
  redraw
  echohl Search | echomsg "file  '".Sou."'  written " | echohl None
endfunction   " ---------- end of function  FilterSaveWithTimestamp  ----------
"
"------------------------------------------------------------------------------
"  insert date and time
"------------------------------------------------------------------------------
function! Filter_InsertDateAndTime ( format )
  if a:format == 'dn' || a:format == 'dtn'
    call Filter_DateAndTime(a:format)
    return
  endif
  if col(".") > 1
    exe 'normal a'.Filter_DateAndTime(a:format)
  else
    exe 'normal i'.Filter_DateAndTime(a:format)
  endif
endfunction    " ----------  end of function Filter_InsertDateAndTime  ----------

"------------------------------------------------------------------------------
"  generate date and time
"------------------------------------------------------------------------------
function! Filter_DateAndTime ( format )
  if a:format == 'd'
    return strftime( s:Filter_FormatDate )
  elseif a:format == 't'
    return strftime( s:Filter_FormatTime )
  elseif a:format == 'dt'
    return strftime( s:Filter_FormatDate ).' '.strftime( s:Filter_FormatTime )
  elseif a:format == 'dn'
    let date  = strftime( s:Filter_FormatDate )
    let rgx   = substitute( date, '\a', 'a', 'g' )
    let rgx   = substitute( rgx, '\d', 'd', 'g' )
    let rgx   = escape( rgx, 'ad.' )
    let line  = getline('.')
    let idxstart  = match( line, rgx )
    if idxstart < 0
      echomsg 'update failed : found no date in this line'
      return
    endif
    let idxend    = matchend( line, rgx )
    call setline( line('.'), line[:idxstart-1].date.line[idxend :] )
  elseif a:format == 'dtn'
    let date  = strftime( s:Filter_FormatDate ).' '.strftime( s:Filter_FormatTime )
    let rgx   = substitute( date, '\a', 'a', 'g' )
    let rgx   = substitute( rgx, '\d', 'd', 'g' )
    let rgx   = escape( rgx, 'ad.' )
    let line  = getline('.')
    let idxstart  = match( line, rgx )
    if idxstart < 0
      echomsg 'update failed : found no date+time in this line'
      return
    endif
    let idxend    = matchend( line, rgx )
    call setline( line('.'), line[:idxstart-1].date.line[idxend :] )
  endif
  return
endfunction    " ----------  end of function Filter_DateAndTime  ----------

"------------------------------------------------------------------------------
"  Filter_CreateGuiMenus
"------------------------------------------------------------------------------
let s:Filter_MenuVisible = -1               " state variable controlling the C-menus
"
function! Filter_CreateGuiMenus ()
  if s:Filter_MenuVisible != 1
    if s:Filter_MenuVisible != -1
      aunmenu <silent> &Tools.Load\ Filter\ Support
    endif
    amenu   <silent> 40.1000 &Tools.-SEP100- :
    amenu   <silent> 40.1210 &Tools.Unload\ Filter\ Support      :call Filter_RemoveGuiMenus()<CR>
    imenu   <silent> 40.1210 &Tools.Unload\ Filter\ Support <C-C>:call Filter_RemoveGuiMenus()<CR>
    call Filter_InitMenu()
    let s:Filter_MenuVisible = 1
  endif
endfunction    " ----------  end of function Filter_CreateGuiMenus  ----------

"------------------------------------------------------------------------------
"  Filter_RemoveGuiMenus
"------------------------------------------------------------------------------
function! Filter_RemoveGuiMenus ()
  if s:Filter_MenuVisible == 1
    if s:Filter_RootMenu == ""
      " no submenu
    else
      exe "aunmenu <silent> ".s:Filter_RootMenu
    endif
    "
    aunmenu <silent> &Tools.Unload\ Filter\ Support
    amenu   <silent> 40.1000 &Tools.-SEP100- :
    amenu   <silent> 40.1210 &Tools.Load\ Filter\ Support      :call Filter_CreateGuiMenus()<CR>
    imenu   <silent> 40.1210 &Tools.Load\ Filter\ Support <C-C>:call Filter_CreateGuiMenus()<CR>
    "
    let s:Filter_MenuVisible = 0
  endif
endfunction    " ----------  end of function Filter_RemoveGuiMenus  ----------
"
"------------------------------------------------------------------------------
"  show / hide the menus
"  define key mappings (gVim only)
"------------------------------------------------------------------------------
"
if has("gui_running")
  "
  if s:Filter_LoadMenus == 'yes'
    call Filter_CreateGuiMenus()
  endif
  "
endif
"
