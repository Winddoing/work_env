

" 鼠标模式
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"mouse 选项的字符决定 Vim 在什么场合下会使用鼠标:
"n       普通模式
"v       可视模式
"i       插入模式
"c       命令行模式
"h       在帮助文件里，以上所有的模式
"a       以上所有的模式
"r       跳过 |hit-enter| 提示
"A		 在可视模式下自动选择
set mouse=a
set mouse=n
set mouse=i
set mouse=c
set mouse=h
set mouse=n
"set mouse=v
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


set selection=exclusive
set clipboard+=unnamed

highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White


set report=0

"set matchtime=5

filetype plugin indent on


"颜色主题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
"colorscheme morning
colorscheme molokai
"colorscheme darkblue
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""
" Uncomment the following to have Vim jump to the last position when reopening a file
 if has("autocmd")
 au BufReadPost * if line("`\"") > 1 && line("`\"") <= line("$") | exe "normal! g`\"" | endif
 endif
"""""""""""""""""""""
  "Only do this part when compiled with support for autocommands.
  if has("autocmd")
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
   " (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  endif " has("autocmd")


""""""""""""""""""""""""""""""






" Fn 快捷键
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"F6 for uncomment
"查找时区分大小写
"nmap <F2> :set ic<cr>/

"F6 for uncomment
"查找时不区分大小写
"nmap <F3> :set noic<cr>/


"F7 for uncomment
vmap <F7> :s=^\(//\)*=//=g<cr>:noh<cr>
nmap <F7> :s=^\(//\)*=//=g<cr>:noh<cr>
imap <F7> <ESC>:s=^\(//\)*=//=g<cr>:noh<cr>

vmap <F7># :s=^\(#\)*=#=g<cr>:noh<cr>
nmap <F7># :s=^\(#\)*=#=g<cr>:noh<cr>
imap <F7># <ESC>:s=^\(#\)*=#=g<cr>:noh<cr>
"F6 for uncomment

vmap <F6> :s=^\(//\)*==g<cr>:noh<cr>
nmap <F6> :s=^\(//\)*==g<cr>:noh<cr>
imap <F6> <ESC>:s=^\(//\)*==g<cr>:noh<cr>
"F12 for uncomment
vmap <F12> :s=^\(//\)*=/*=g<cr>:s=\(//\)*$=*/=g<cr>:noh<cr>
nmap <F12> :s=^\(//\)*=/*=g<cr>:s=\(//\)*$=*/=g<cr>:noh<cr>
imap <F12> <ESC>:s=^\(//\)*=/*=g<cr>:s=\(//\)*$=*/=g<cr>:noh<cr>

"F9 for uncomment
vmap <F9> :s=^\(\/\*\)*==g<cr>:s=\(\*\/\)*$==g<cr>:noh<cr>
nmap <F9> :s=^\(\/\*\)*==g<cr>:s=\(\*\/\)*$==g<cr>:noh<cr>
imap <F9> <ESC>:s=^\(\/\*\)*==g<cr>:s=\(\*\/\)*$==g<cr>:noh<cr>
"-----------------------------------------------------csc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" 开启文件类型侦测
filetype on

" 根据侦测到的不同类型加载对应的插件
" Enable filetype plugin
filetype plugin on
" 自适应不同语言的智能缩进
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ";"
let g:mapleader = ";"

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vim_runtime/vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim_runtime/vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

" 显示光标当前位置
set ruler "Always show current position

set cmdheight=1 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

""Ignore case when searching
set ignorecase
set smartcase

" 高亮显示搜索结果
set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set selection=exclusive

set selectmode=mouse,key
"Ctrl+I 开启右键复制项
"map <C-I> :set mouse=<CR>
""Ctrl+L  禁用右键复制项
map <C-L> :set mouse=a<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 开启语法高亮功能
"syntax enable "Enable syntax hl

" Set font according to system
"  set gfn=Monospace\ 10
"  set shell=/bin/bash

"if has("gui_running")
"  set guioptions-=T
"  set t_Co=256
"  set background=dark
"  colorscheme peaksea
"  set nonu
"else
"  colorscheme zellner
"  set background=dark

"  set nonu
"endif

"set encoding=utf8
"try
"    lang en_US
"catch
"endtry

"set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
"set nobackup
set nowb
set noswapfile
"set swapfile

"Persistent undo
try
    if MySys() == "windows"
      set undodir=C:\Windows\Temp
    else
      set undodir=~/.vim_runtime/undodir
    endif

    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set shiftwidth=8
"set softtabstop=8
"set tabstop=8

" 设置格式化时制表符占用空格数
set shiftwidth=4

" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" 设置编辑时制表符占用空格数
set tabstop=4

"set smarttab
set noexpandtab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Useful on some European keyboards
map 陆 $
imap 陆 $
vmap 陆 $
cmap 陆 $


func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

" Tab configuration
"map <leader>tn :tabnew<cr>
"map <leader>te :tabedit
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
"map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
"  set stal=2           //shang mian xian shi
catch
endtry


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i
"inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplVSplit = 25
"let g:miniBufExplSplitBelow=1

let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1

let g:bufExplorerSortBy = "name"

autocmd BufRead,BufNew :call UMiniBufExplorer
map <leader>u :TMiniBufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""""""""""
let g:CommandTMaxHeight = 15
set wildignore+=*.o,*.obj,.git,*.pyc
noremap <leader>j :CommandT<cr>
noremap <leader>y :CommandTFlush<cr>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>
au BufRead,BufNewFile ~/buffer iab <buffer> xh1 ===========================================

map <leader>pp :setlocal paste!<cr>

map <leader>bb :cd ..<cr>

set csprg=/usr/bin/cscope
set csto=0
set cst
set csverb
set cscopetag
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWindowLayout='FileExplorer'
"map <F4> :WMToggle<CR>
set iskeyword+=_,$,@,%,#,-

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Auto_Open=0
nnoremap <F8> :TlistToggle<CR>
set tags=tags;
filetype plugin indent on
set completeopt=longest,menu
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"

set autoindent
set cindent

" 带有如下符号的单词不要被换行分割

 set iskeyword+=_,$,@,%,#,-


if &term=="xterm"
"set t_Co=8
set t_Sb=^[[4%dm
set t_Sf=^[[3%dm
endif

":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
if getline('.')[col('.') - 1] == a:char
return "\<Right>"
else
return a:char
endif
endf

set tags=tags;\
set path+=include;\

set listchars=tab:>-,trail:-
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/



"折叠方式"zf创建折叠
"set fdm=indent
set fdm=manual

vmap <C-S-P> dO#endif<Esc>PO#if 0<Esc>

"set notextmode

"以unix格式显示换行符
nmap xsm :e ++ff=unix
"以dos格式显示换行符
nmap xsm :e ++ff=dos

"set filetype=unix
"删除行尾的一个^M
nmap dm :%s/\r\+$//e<cr>:set ff=unix<cr>
"以UNIX的换行符格式保存文件，注意是去掉一个^M
":set ff=unix
"以dos的换行符格式保存文件, 注意是在行尾变为两个^M
"set ff=dos
let Tlist_Use_Right_Window = 1

"add doxygen
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F2> :DoxAuthor<cr>/
nmap <F3> :Dox<cr>/

let g:DoxygenToolkit_commentType = "C"
let g:DoxygenToolkit_briefTag_pre="@brief  "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@returns   "
let g:DoxygenToolkit_dateTag="@date "
let g:DoxygenToolkit_versionTag="@version "
let g:DoxygenToolkit_versionString="1.0"
let g:DoxygenToolkit_authorName="wqshao, wangquan.shao@ingenic.com"
let s:licenseTag = "Copyright(C)\<enter>"
let s:licenseTag = s:licenseTag . "For free\<enter>"
let s:licenseTag = s:licenseTag . "All right reserved\<enter>"
let g:DoxygenToolkit_licenseTag = s:licenseTag

let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"新建.c,.h,.sh,.java文件，自动插入文件头
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.cpp set filetype=cpp
au BufRead,BufNewFile *.c set filetype=c
au BufRead,BufNewFile *.sh set filetype=sh
au BufRead,BufNewFile *.py set filetype=python
au BufRead,BufNewFile *.dot set filetype=dot
autocmd BufNewFile *.cpp,*.c,*.sh,*.py,*.dot exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
	if &filetype == 'python'
		call setline(1, "\#coding=utf8")
		call setline(2, "\"\"\"")
		call setline(3, "\# File Name	: ".expand("%"))
		call setline(4, "\# Author	: wqshao")
		call setline(5, "\# Created Time	: ".strftime("%c"))
		call setline(6, "\# Description	:")
		call setline(7, "")
		call setline(8, "\"\"\"")
		call setline(9,"")
	endif
	if &filetype == 'sh' "如果文件类型为.sh文件
        call setline(1,"\##########################################################")
        call append(line("."), "\# File Name		: ".expand("%"))
        call append(line(".")+1, "\# Author		: wqshao")
        call append(line(".")+2, "\# Created Time	: ".strftime("%c"))
		call append(line(".")+3, "\# Description	:")
        call append(line(".")+4, "\##########################################################")
        call append(line(".")+5, "\#!/bin/bash")
        call append(line(".")+6, "")
    endif
    if &filetype == 'cpp'
        call setline(1, "/*#############################################################")
        call append(line("."), " *     File Name	: ".expand("%"))
        call append(line(".")+1, " *     Author		: wqshao")
        call append(line(".")+2, " *     Created Time	: ".strftime("%c"))
        call append(line(".")+3, " *     Description	:")
        call append(line(".")+4, " *############################################################*/")
        call append(line(".")+5, "")
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call setline(1, "/*#############################################################")
        call append(line("."), " *     File Name	: ".expand("%"))
        call append(line(".")+1, " *     Author		: wqshao")
        call append(line(".")+2, " *     Created Time	: ".strftime("%c"))
        call append(line(".")+3, " *     Description	:")
        call append(line(".")+4, " *############################################################*/")
        call append(line(".")+5, "")
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+7, "#include <stdlib.h>")
        call append(line(".")+8, "")
    endif
	if &filetype == 'dot'
		call setline(1,"//usr/bin/dot")
		call append(1,"digraph G{")
		call append(2,"")
		call append(3,"}")
		normal 3G
	endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G

endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"文本编码
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"属性设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 在处理未保存或只读文件的时候，弹出确认
"set confirm

" 去掉输入错误的提示声音
set noeb

" 高亮显示当前行/列
set cursorline
"set cursorcolumn

" 开启行号显示
set nu

" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 分割线显示
" color set: ColorColumn
set colorcolumn=80
" Make it obvious where 80 characters is
"set textwidth=110
"set colorcolumn=+1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 快捷键
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $

nmap qq :q!<cr>

nmap tt :Tlist<cr>
nmap ww <C-w><C-w>
nmap -- 5<C-w>-
nmap ++ 5<C-w>+
nmap >> 5<C-w>>
nmap << 5<C-w><
nmap 11 :set nonu<cr>
nmap 22 :set nu<cr>
nmap cm :!
map ss :split<cr>
map vv :vsplit<cr>
nmap ff :1,$s///g
nmap fk :1,$s/ *$//g<cr>
"nmap fk :1,$s/^.*\.//g<cr>	"exaple 12.aaa-->aaa

"取出多余空格
nmap ds :%s/\s\+$//<cr>

"nmap ff :cs find t <C-R>=expand("<cword>")<CR><CR>:cw<CR>
map dk oprintk("===> func: %s, line: %d\n", __func__, __LINE__);<Esc>
map df oprintf("===> func: %s, line: %d\n", __func__, __LINE__);<Esc>
" oxxxx  o -- vi edit

"set pastetoggle=
"autocmd InsertEnter * setlocal paste
"autocmd InsertLeave * setlocal nopaste

"将case 标记之后的语句放在标记缩进位置之后的 N 个字符处。(省缺'shiftwidth')。
set cinoptions=:N,lN,bN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"插件管理  vundle 环境设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'Lokaltog/vim-powerline'
"Plugin 'octol/vim-cpp-enhanced-highlight'  "改变函数名称颜色
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
"Plugin 'Yggdroot/indentLine'
Plugin 'lilydjwg/fcitx.vim'
"Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
"Plugin 'tacahiroy/ctrlp-funky'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'oplatek/Conque-Shell'
Plugin 'aklt/plantuml-syntax'
Plugin 'wannesm/wmgraphviz.vim'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'plasticboy/vim-markdown'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'mzlogin/vim-kramdown-tab'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'Raimondi/delimitMate'
Plugin 'rkulla/pydiction'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'msanders/snipmate.vim'

" 插件列表结束
call vundle#end()
filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 插件设置

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
">>>>>>>>>vim-cpp-enhanced-highlight
" STL 容器类型高亮
syntax keyword cppSTLtype initializer_list


">>>>>>>>>vim-indent-guides
" 随 vim 自启动
"let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=1
" 色块宽度
let g:indent_guides_guide_size=0
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>ig <Plug>IndentGuidesToggle

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=2
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=4


" 基于缩进或语法进行代码折叠
set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable
"操作：za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠


">>>>>>>>vim-powerline
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible
set t_Co=256
let g:Powerline_symbols = 'unicode'


">>>>>>>>vim-fswitch
" *.cpp 和 *.h 间切换
nmap <silent> <Leader>sw :FSHere<cr>
"操作: 键入 [;sw] 就能在实现文件和接口文件间切换


">>>>>>>>supertab
"SuperTab使Tab快捷键
"let g:SuperTabMappingForward = "<tab>"
"let g:SuperTabMappingBackward= "s-tab"  " Tab空格使用Shift+<tab>
"let g:SuperTabDefaultCompletionType="context"


">>>>>>>>ctrlp.vim
"查找文件  Ctrl+p
"let g:ctrlp_match_window = 'top,order:btt,min:1,max:10,results:20'
"let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files.
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " Ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif
">>>>>>>>ctrlp-funky
"模糊搜索当前文件中所有函数
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']

">>>>>>>>nerdtre
"树形目录
nmap <F4> :NERDTreeToggle<cr>

">>>>>>>>ag.vim
"当前目录下，全局搜索
let g:ackprg = 'ag --nogroup --nocolor --column'

">>>>>>>>vim-fugitive
"显示：当前模式、Git分支、文件路径、文件是否保存以及当前所载行和 列的信息。这是通过vim-powerline来实现的。
set laststatus=2 " Always display the status line
set statusline+=%{fugitive#statusline()} "  Git Hotness

">>>>>>>>> Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F8> :TagbarToggle<CR>

">>>>>>>>Conque-Shell
"vim + shell
"nmap <C-r> :ConqueTermVSplit bash <cr>
"nmap <C-P> :ConqueTermSplit bash <cr>
nmap <C-b> :ConqueTermVSplit bash <cr>

">>>>>>>>plantuml-syntax
"vim + plantuml
let g:plantuml_executable_script = 'java -jar ~/.vim/until/plantuml.jar'
nnoremap <silent> <F5> :w<CR> :make<CR>
inoremap <silent> <F5> <Esc>:w<CR>:make<CR>
vnoremap <silent> <F5> :<C-U>:w<CR>:make<CR>

">>>>>>>>wmgraphviz.vim
" vim + dot
" Compiling: :GraphvizCompile, <LocalLeader>ll
" Viewing: :GraphvizShow, <LocalLeader>lv
" Interactive viewing + editing: :GraphvizInteractive, <LocalLeader>li


">>>>>>>>markdown-preview.vim
" vim + makedown + firefox
let g:mkdp_path_to_chrome = "firefox"
" 设置 chrome 浏览器的路径（或是启动 chrome（或其他现代浏览器）的命令）
let g:mkdp_auto_start = 0
" 设置为 1 可以在打开 markdown 文件的时候自动打开浏览器预览，只在打开markdown 文件的时候打开一次
let g:mkdp_auto_open = 0
" 设置为 1 在编辑 markdown 的时候检查预览窗口是否已经打开，否则自动打开预览窗口
let g:mkdp_auto_close = 1
" 在切换 buffer 的时候自动关闭预览窗口，设置为 0 则在切换 buffer 的时候不自动关闭预览窗口
let g:mkdp_refresh_slow = 0
" 设置为 1 则只有在保存文件，或退出插入模式的时候更新预览，默认为 0，实时更新预览

"nmap <silent> <F8> <Plug>MarkdownPreview
"imap <silent> <F8> <Plug>MarkdownPreview
nmap M :MarkdownPreview <cr>
nmap <silent> <F10> <Plug>StopMarkdownPreview
imap <silent> <F10> <Plug>StopMarkdownPreview

">>>>>>>mathjax-support-for-mkdp
"支持数学公式显示

">>>>>>>vim-markdown
"语法高亮
let g:vim_markdown_frontmatter=1

">>>>>>>vim-markdown-toc
"生成文章目录
let g:vmt_auto_update_on_save = 1
"用于控制保存文件时是否自动更新已有文章目录，关闭为0
"let g:vmt_dont_insert_fence = 1
"关闭生成文章目录的时候会在前后插入 <!-- vim-markdown-toc -->
"使用命令：
":GenTocGFM  生成 GFM 链接风格的文章目录。
":GenTocRedcarpet  生成 Redcarpet 链接风格的文章目录。
":UpdateToc 更新已有目录

">>>>>>>vim-kramdown-tab
"列表缩进


">>>>>>>vim-table-mode
"表格的排版
let g:table_mode_corner='|'
let g:table_mode_header_fillchar='-'
let g:table_mode_delimiter=' '
"先生成表格内容，用空格分隔, 使用命令:Tableize

">>>>>>>>delimitMate
"自动补全引号(单引号/双引号/反引号), 括号(()[]{})]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

">>>>>>>pydiction
"Python自动补全
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 5

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
">>>>>>>>minibufexpl.vim
"打开多文件编辑
"下一个buf
nmap aa :bnext<cr>
"前一个buf
nmap zz :bprevious<cr>
":b<n>    n是数字，第n个buf
nmap bb :b

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

">>>>>>>>>>neocomplcache.vim
" 提示补全
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_force_overwrite_completefunc = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

