"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  Vim initialization file
"       AUTHOR:  Dr.-Ing. Fritz Mehner
"        EMAIL:  mehner@fh-swf.de
"      COMPANY:  FH Südwestfalen, Iserlohn
"      CREATED:  02.04.2005 - 17:30:25
"     REVISION:  14.07.2014
"===================================================================================
"
"===================================================================================
" GENERAL SETTINGS			{{{1
"===================================================================================

"-------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
"-------------------------------------------------------------------------------
""set nocompatible
"
"-------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
"-------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
"-------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-------------------------------------------------------------------------------
syntax    on            
"
"-------------------------------------------------------------------------------
" Platform specific items			{{{2
" - central backup directory (has to be created)
" - default dictionary
"-------------------------------------------------------------------------------
if  has("win16") || has("win32") || has("win64") || has("win95")
"
"  runtime mswin.vim
"  set backupdir =$VIM\vimfiles\backupdir
"  set dictionary=$VIM\vimfiles\wordlists/german.list
else
  set backupdir =$HOME/.vim.backupdir
  set dictionary=$HOME/.vim/wordlists/german.list,$HOME/.vim/wordlists/english.list
endif
"
"-------------------------------------------------------------------------------
" Various settings			{{{2
"-------------------------------------------------------------------------------
set autoindent                  " copy indent from current line
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode
set backup                      " keep a backup file
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan the files given with the 'dictionary' option
set history=50                  " keep 50 lines of command line history
set hlsearch                    " highlight the last used search pattern
set incsearch                   " do incremental searching
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
set mouse=a                     " enable the use of the mouse
set nowrap                      " do not wrap lines
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set shiftwidth=2                " number of spaces to use for each step of indent
set showcmd                     " display incomplete commands
set smartindent                 " smart autoindenting when starting a new line
set tabstop=2                   " number of spaces that a <Tab> counts for
set visualbell                  " visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode
set scrolloff=1                 " number of lines to keep above and below the cursor
"
set foldmethod=indent           " the kind of folding
set nofoldenable                " keep all folds open
"
"===================================================================================
" BUFFERS, WINDOWS			{{{1
"===================================================================================
"
"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.	{{{2
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufEnter * :lchdir %:p:h
endif
"
"-------------------------------------------------------------------------------
" close window (conflicts with the KDE setting for calling the process manager)	{{{2
"-------------------------------------------------------------------------------
 noremap  <C-Esc>       :close<CR>
inoremap  <C-Esc>  <C-C>:close<CR>
"
"-------------------------------------------------------------------------------
" Fast switching between buffers			{{{2
" The current buffer will be saved before switching to the next one.
"-------------------------------------------------------------------------------
nnoremap  <silent>   <tab>       :if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>       :if &modifiable && !&readonly && 
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"
"-------------------------------------------------------------------------------
" Leave the editor with Ctrl-q (KDE): Write all changed buffers,  exit			{{{2
"-------------------------------------------------------------------------------
nnoremap  <C-q>    :wqall<CR>
"
"-------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.			{{{2
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")
"
"-------------------------------------------------------------------------------
"  additional hot keys			{{{2
"-------------------------------------------------------------------------------
"     F2  -  write file without confirmation
"     F3  -  call file explorer Ex
"     F4  -  show tag under curser in the preview window (tagfile must exist!)
"     F5  -  show the current list of errors
"     F6  -  close the quickfix window (error list)     
"     F7  -  display previous error
"     F8  -  display next error   
"-------------------------------------------------------------------------------
noremap   <silent> <F2>         :write<CR>
noremap   <silent> <F3>         :Explore<CR>
noremap   <silent> <F4>         :execute ":ptag ".expand("<cword>")<CR>
noremap   <silent> <F5>         :copen<CR>
"
inoremap  <silent> <F2>    <C-C>:write<CR>
inoremap  <silent> <F3>    <C-C>:Explore<CR>
inoremap  <silent> <F4>    <C-C>:execute ":ptag ".expand("<cword>")<CR>
inoremap  <silent> <F5>    <C-C>:copen<CR>
"
 noremap   <silent> <F7>        :call SwitchF7()<CR>
inoremap   <silent> <F7>   <C-C>:call SwitchF7()<CR>
 noremap   <silent> <F8>        :call SwitchF8()<CR>
inoremap   <silent> <F8>   <C-C>:call SwitchF8()<CR>


function! QFixToggle()
  if exists("g:qfix_win") 
    cclose
    unlet g:qfix_win
  else
    copen
    let g:qfix_win = bufnr("$")
  endif
endfunction
 noremap   <silent> <F6>         :call QFixToggle()<CR>
inoremap   <silent> <F6>    <C-C>:call QFixToggle()<CR>

function! SwitchF7 ()
  if &spell
    normal [s
  else
    silent! exe ":cprevious"
  endif
endfunction    " ----------  end of function SwitchF7  ----------

function! SwitchF8 ()
  if &spell
    normal ]s
  else
    silent! exe ":cnext"
  endif
endfunction    " ----------  end of function SwitchF8  ----------
"
"-------------------------------------------------------------------------------
" resize the current window			{{{2
"-------------------------------------------------------------------------------
nnoremap <silent> <M-Up>    :resize+2<CR>
nnoremap <silent> <M-Down>  :resize-2<CR>
nnoremap <silent> <M-Right> :vertical resize+2<CR>
nnoremap <silent> <M-Left>  :vertical resize-2<CR>
"
"-------------------------------------------------------------------------------
" use Q to reformat a paragraph        {{{2
"-------------------------------------------------------------------------------
map Q gq
"
"-------------------------------------------------------------------------------
" search and highlight and do not jump        {{{2
"-------------------------------------------------------------------------------
nnoremap * *N
nnoremap # #N
"
"-------------------------------------------------------------------------------
" comma always followed by a space			{{{2
"-------------------------------------------------------------------------------
inoremap  ,  ,<Space>
"
"-------------------------------------------------------------------------------
" autocomplete parenthesis, (brackets) and braces			{{{2
"-------------------------------------------------------------------------------
inoremap  (           ()<Left>
inoremap  (;          (<Space><Space>);<Left><Left><Left>
inoremap  (<Space>    (<Space><Space>)<Left><Left>
vnoremap  (          s()<Esc>P<Right>%

inoremap  [           []<Left>
inoremap  [;          [];<Left><Left>
inoremap  [<Space>    [<Space><Space>]<Left><Left>
vnoremap  [          s[]<Esc>P<Right>%

inoremap  {           {}<Left>
inoremap  {;          {<Space><Space>};<Left><Left><Left>
inoremap  {<Space>    {<Space><Space>}<Left><Left>
vnoremap  {          s{}<Esc>P<Right>%
"
" surround content with additional spaces
vnoremap  )  s(<Space><Space>)<Esc><Left>P2<Right>%
vnoremap  ]  s[<Space><Space>]<Esc><Left>P2<Right>%
vnoremap  }  s{<Space><Space>}<Esc><Left>P2<Right>%
"
" jump out of parenthesis and quotes
inoremap <silent>  <C-j>  <Esc>:call search( "[\"'\])}]", 'cW'  )<CR>a
"
"-------------------------------------------------------------------------------
" autocomplete quotes (visual and insert mode)			{{{2
"-------------------------------------------------------------------------------
vnoremap <silent> ' <Esc>:call QuoteSurroundWrapper("'")<CR>
vnoremap <silent> " <Esc>:call QuoteSurroundWrapper('"')<CR>
vnoremap <silent> ` <Esc>:call QuoteSurroundWrapper('`')<CR>
"
inoremap <silent> ' <c-r>=QuoteInsertionWrapper("'")<CR>
inoremap <silent> " <c-r>=QuoteInsertionWrapper('"')<CR>
inoremap <silent> ` <c-r>=QuoteInsertionWrapper('`')<CR>
"
"-------------------------------------------------------------------------------
" function QuoteInsertionWrapper			{{{3
"
" Add a second quote only if the left and the right character are not keyword
" characters and the right character is not the same quote.
"-------------------------------------------------------------------------------
function! QuoteInsertionWrapper (quote)
  let col   = col('.')
  let line  = getline('.')
  if    ( line[col-2] =~ '\k'    )
  \  || ( line[col  ] =~ '\k'    )
  \  || ( line[col-2] =~ a:quote )
  \  || ( line[col  ] =~ a:quote )
    return a:quote
  else
    return a:quote.a:quote."\<Left>"
  endif
endfunction 

"-------------------------------------------------------------------------------
" function QuoteSurroundWrapper			{{{3
"
" Add, replace, or remove quotes :
"  quote ' :   xxxxxx    =>  'xxxxxx'  ( add     )
"  quote ' :  "xxxxxx"   =>  'xxxxxx'  ( replace )
"  quote ' :  'xxxxxx'   =>   xxxxxx   ( remove  )
"
"  quote " :   xxxxxx    =>  'xxxxxx'  ( add     )
"  quote " :  'xxxxxx'   =>  "xxxxxx"  ( replace )
"  quote " :  "xxxxxx"   =>   xxxxxx   ( remove  )
"
"-------------------------------------------------------------------------------
function! QuoteSurroundWrapper (quote)
  " substitute marked text and add a blank:
  exe  'normal gvs '
  let colnr  = col(".")                         " position of the blank
  let string = getreg('"')                      " read from the unnamed register

  if      ( a:quote == "'" && string[0] == '"' && string[-1:] == '"' )
  \   ||  ( a:quote == '"' && string[0] == "'" && string[-1:] == "'" )
    "
    let @"  = a:quote.string[1:-2].a:quote      " reload the unnamed register
    "
  elseif  ( a:quote == string[0] && string[0] == string[-1:] )  
    "
    let @"  = string[1:-2]                      " reload the unnamed register
    "
  else
    let @"  = a:quote.string.a:quote            " reload the unnamed register
  endif
  " insert and remove the blank:
  normal p
  call cursor( 0, colnr )                       " back to the extra blank
  normal x
endfunction    " ----------  end of function QuoteSurroundWrapper  ----------
"
"-------------------------------------------------------------------------------
" Set maximum width of text for a new text file.		{{{2
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd FileType text setlocal textwidth=78
"  autocmd FileType c,cpp setlocal textwidth=88
endif " has("autocmd")
"
"-------------------------------------------------------------------------------
"  highlight paired brackets		{{{2
"-------------------------------------------------------------------------------
highlight MatchParen ctermbg=lightgreen guibg=lightyellow

"-------------------------------------------------------------------------------
" thesaurus		{{{2
"-------------------------------------------------------------------------------
set thesaurus+=$HOME/.vim/thesaurus/thesaurus.mehner.txt
set thesaurus+=$HOME/.vim/thesaurus.moby/mthesaur.txt
"
"
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS			{{{1
"===================================================================================
"
"-------------------------------------------------------------------------------
" plugin bash-support.vim		{{{2
"-------------------------------------------------------------------------------
"
"-------------------------------------------------------------------------------
" buffer explorer		{{{2
"   F12 -  toggle buffer explorer window
"-------------------------------------------------------------------------------
 noremap  <silent> <F12>        :BufExplorer<CR>
inoremap  <silent> <F12>   <C-C>:BufExplorer<CR>

"-------------------------------------------------------------------------------
" plugin c.vim		{{{2
"-------------------------------------------------------------------------------
let g:C_XtermDefaults   			= "-fa courier -fs 12 -geometry 96x32"
let g:C_GuiTemplateBrowser 		= 'explorer'

let g:C_Dictionary_File = $HOME.'/.vim/c-support/wordlists/c-c++-keywords.list,'.
      \                   $HOME.'/.vim/c-support/wordlists/k+r.list,'.
      \                   $HOME.'/.vim/lua-support/wordlists/lua-c-api.list'

let g:C_Styles				= { '*.c,*.h' : 'default', '*.cc,*.cpp,*.c++,*.C,*.hh,*.h++,*.H' : 'CPP' }
let g:C_Styles				= { '*.c,*.h' : 'C', '*.cc,*.cpp,*.c++,*.C,*.hh,*.h++,*.H' : 'CPP' }

let g:Doxygen_Executable = 'doxygen'
let g:C_UseTool_doxygen  = 'yes'

let g:C_CplusCFlags	= ' -std=c++11 -pthread -Wall -Wextra -g -O0 -c'
let g:C_CplusLFlags	= ' -std=c++11 -pthread -Wall -Wextra -g -O0'

"-------------------------------------------------------------------------------
" plugin perl-support.vim		{{{2
"-------------------------------------------------------------------------------
let g:Perl_Dictionary_File    = $HOME.'/.vim/perl-support/wordlists/perl.list,'.
                            \   $HOME.'/.vim/c-support/wordlists/k+r.list'
"
let perl_include_pod 					= 1               " enable POD syntax highlighting
let g:Perl_Ctrl_j 						= 'on'
let g:Perl_PerlTags						= 'on'
let g:Perl_GuiTemplateBrowser = 'explorer'
let g:Perl_NYTProf_html 			= 'yes'
let g:Perl_ProfilerTimestamp 	= "yes"
let g:Perl_HardcopyCommand		= "a2ps --silent --chars-per-line=92 --tabsize=4 --portrait --borders 0 --columns=1 --output='%'.ps '%'"
let g:Perl_Perltidy						= 'on'
let g:Perl_LoadMenus      =         'yes'


"-------------------------------------------------------------------------------
" plugin textfilter.vim		{{{2
"-------------------------------------------------------------------------------
let g:Filter_a2psOptions       = '--silent --chars-per-line=92 --portrait --borders 0 --columns=1'
"            
"
"-------------------------------------------------------------------------------
" plugin taglist.vim		{{{2
" - toggle the taglist window
" - various settings
" - define the tag file entry for BibTeX
" - define the tag file entry for html
" - define the tag file entry for make
" - define the tag file entry for Perl
" - define the tag file entry for qmake
" - define the tag file entry for LaTeX
" - define the tag file entry for Vim help
" - define the tag file entry for db
" - define the tag file entry for template files
"-------------------------------------------------------------------------------
 noremap <silent> <F11>       :TlistToggle<CR>
inoremap <silent> <F11>  <C-C>:TlistToggle<CR>

let Tlist_GainFocus_On_ToggleOpen =  1
let Tlist_Close_On_Select 				=  1
let Tlist_Inc_Winwidth   					=  0
let Tlist_WinWidth       					= 25

let tlist_c_settings 				= 'c;d:macro;g:enum;s:struct;u:union;t:typedef;' .
                           			\ 'v:variable;f:function;o:TODO'
let tlist_cpp_settings 			= 'c++;n:namespace;v:variable;d:macro;t:typedef;' .
                             		\ 'c:class;g:enum;s:struct;u:union;f:function;o:TODO'
let tlist_conf_settings  		= 'conf;c:configuration'
let tlist_bib_settings   		= 'bibtex;s:BibTeX-Strings;a:BibTeX-Authors;e:BibTeX-Entries;t:BibTeX-Titles'
let tlist_html_settings  		= 'html;a:anchor;h:href;t:table'
let tlist_make_settings  		= 'make;m:makros;t:targets;i:includes'
let tlist_perl_settings  		= 'perl;c:constants;f:formats;l:labels;p:packages;'.
															\ 's:subroutines;d:subroutines;o:POD;k:comments'
let tlist_qmake_settings 		= 'qmake;t:SystemVariables'
let tlist_tex_settings   		= 'latex;s:Contents;g:Graphics;i:Listings;l:\label;r:\ref;p:\pageref;b:\bibitem'

let tlist_help_settings  		= 'help;h:help;l:label'
let tlist_template_settings	= 'template;t:template'

let tlist_db_settings    		= 'db;d:Lemma'
let tlist_help_settings  		= 'help;h:help;l:label'
let tlist_vim_settings  		= 'vim;a:augroup;c:command;f:function;m:map;v:variable;p:Perl'

let tlist_sh_settings  			= 'sh;f:function;g:globals;o:TODO'
"
"-------------------------------------------------------------------------------
" plugin templates : set filetype for *.template (used in ~/.ctags) 
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufNewFile,BufRead   Templates  set filetype=template
  autocmd BufNewFile,BufRead *.template  set filetype=template
endif " has("autocmd")

"-------------------------------------------------------------------------------
" qmake : set filetype for *.pro  		{{{2
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufNewFile,BufRead *.pro  set filetype=qmake
endif " has("autocmd")

"-------------------------------------------------------------------------------
" plugin mru.vim : number of files		{{{2
"-------------------------------------------------------------------------------
let MRU_Max_Entries     	= 70
let MRU_Exclude_Files 		= '^/tmp/.*\|^smallprof.out'  " For Unix

"-------------------------------------------------------------------------------
" Explorer : detailed list		{{{2
"-------------------------------------------------------------------------------
let g:netrw_liststyle     = 1
let g:netrw_hide          = 1
let g:netrw_list_hide     = '^\..*'
let g:netrw_sort_sequence = '[\/]$,*'
"
"-------------------------------------------------------------------------------
" spell checking		{{{2
"-------------------------------------------------------------------------------
highlight SpellBad   guifg=blue   guibg=lightred  cterm=NONE
highlight SpellBad ctermfg=blue ctermbg=white     cterm=NONE
set spelllang=de
"
an 40.335.145 &Tools.&Spelling.&Add\ to\ dictionary<Tab>zg  zg
"
"===================================================================================
" ABBREVIATIONS			{{{1
"===================================================================================
"
"===================================================================================
" EXPERIMENTAL SETTINGS			{{{1
"===================================================================================
"
"-------------------------------------------------------------------------------
" vim: foldmethod=marker foldlevel=1
