# 系统剪切板
set clipboard=unnamedplusset

# <leader>前缀键
let mapleader=";"

# 将ctrl+p快捷键还原到vscode配置
nnoremap <C-p> <Nop>
inoremap <C-p> <Nop>

# 设置缩进使用 Tab 字符（而非空格）
set noexpandtab
# 启用智能缩进
set smartindent
# 启用自动缩进
set autoindent

# 查找所有引用
#nnoremap <leader>s :call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>
#vnoremap <leader>s :call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>
