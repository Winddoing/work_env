"新建.c,.h,.sh,文件，自动插入文件头
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.dot set filetype=dot
au BufRead,BufNewFile *.uml set filetype=uml

autocmd BufNewFile *.cpp,*.c,*.sh,*.py,*.dot,*.uml,*.h exec ":call SetTitle()"

"定义函数SetTitle，自动插入文件头
func SetTitle()
	let $author_name = $USER
	let $crt_name = $USERNAME
	if &filetype == 'sh'
		call setline(1,        "#!/bin/bash")
		call append(line("$"), "##########################################################")
		call append(line("$"), "# Copyright (C) ".strftime("%Y")." ".$crt_name." All rights reserved.")
		call append(line("$"), "#  File Name    : ".expand("%:t"))
		call append(line("$"), "#  Author       : ".$author_name)
		call append(line("$"), "#  Created Time : ".strftime("%F %T"))
		call append(line("$"), "#  Description  :")
		call append(line("$"), "##########################################################")
		call append(line("$"), "")
		normal G

	elseif &filetype == 'python'
		call setline(1,        "#!/usr/bin/python3")
		call append(line("$"), "# -*- coding:utf-8 -*-")
		call append(line("$"), "")
		call append(line("$"), "#  File Name    : ".expand("%:t"))
		call append(line("$"), "#  Author       : ".$author_name)
		call append(line("$"), "#  Created Time : ".strftime("%F %T"))
		call append(line("$"), "#  Description  :")
		call append(line("$"), "")
		call append(line("$"), "")
		normal G

	elseif &filetype == 'dot'
		call setline(1,        "//usr/bin/dot")
		call append(line("$"), "digraph G{")
		call append(line("$"), "")
		call append(line("$"), "")
		call append(line("$"), "}")
		normal 3G

	elseif &filetype == 'uml'
		call setline(1,        "@startuml")
		call append(line("$"), "title xxxx")
		call append(line("$"), "")
		call append(line("$"), "")
		call append(line("$"), "@enduml")
		normal 3G

	else
		call setline(1,        "/* Copyright (C) ".strftime("%Y")." ".$crt_name." All rights reserved.")
		call append(line("$"), " *")
		call append(line("$"), " *  File Name    : ".expand("%:t"))
		call append(line("$"), " *  Author       : ".$author_name)
		call append(line("$"), " *  Created Time : ".strftime('%F %T'))
		call append(line("$"), " *  Description  :")
		call append(line("$"), " */")
		call append(line("$"), "")
		if expand("%:e") == 'c'
			call append(line("$"), "#include <stdio.h>")
			call append(line("$"), "#include <stdlib.h>")
			call append(line("$"), "#include <stdint.h>")
			call append(line("$"), "")
			normal G
		elseif expand("%:e") == 'cpp'
			call append(line("$"), "#include <iostream>")
			call append(line("$"), "")
			call append(line("$"), "using namespace std;")
			call append(line("$"), "")
			normal G
		elseif expand("%:e") == 'h'
			call append(line("$"), "#ifndef __".toupper(expand("%:t:r"))."_H__")
			call append(line("$"), "#define __".toupper(expand("%:t:r"))."_H__")
			call append(line("$"), "")
			call append(line("$"), "#ifdef __cplusplus")
			call append(line("$"), "extern \"C\"")
			call append(line("$"), "{")
			call append(line("$"), "#endif")
			call append(line("$"), "")
			call append(line("$"), "")
			call append(line("$"), "#ifdef __cplusplus")
			call append(line("$"), "}")
			call append(line("$"), "#endif")
			call append(line("$"), "")
			call append(line("$"), "#endif//__".toupper(expand("%:t:r"))."_H__")
			normal 16G
		endif

	endif

endfunc

