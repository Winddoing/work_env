
<!-- vim-markdown-toc GFM -->

* [安装 VIM8.x](#安装-vim8x)
    * [ubuntu](#ubuntu)
    * [Centos7](#centos7)
    * [自动化安装配置](#自动化安装配置)
* [插件管理](#插件管理)
* [常用操作](#常用操作)
    * [Fn功能键](#fn功能键)
    * [快捷键](#快捷键)
    * [ctags](#ctags)
    * [cscope](#cscope)
    * [字符串替换](#字符串替换)
    * [标记-Mark](#标记-mark)
        * [添加标记](#添加标记)
        * [跳转标记](#跳转标记)
        * [查看标记](#查看标记)
        * [删除标记](#删除标记)
    * [文件对比](#文件对比)
    * [符号对齐](#符号对齐)
        * [等号对齐](#等号对齐)
        * [空格对齐](#空格对齐)
    * [session会话](#session会话)
        * [自动加载恢复](#自动加载恢复)
    * [拷贝系统剪切板](#拷贝系统剪切板)
    * [vim中使用grep](#vim中使用grep)
    * [将文档中同一字符串转为大写](#将文档中同一字符串转为大写)
    * [匹配数字，进行运算，使用运算结果替换](#匹配数字进行运算使用运算结果替换)
    * [其他](#其他)
        * [多个标签切换](#多个标签切换)
        * [十六进制显示](#十六进制显示)
* [修改配置](#修改配置)
    * [代码注释颜色](#代码注释颜色)
* [插件使用](#插件使用)
    * [vim-markdown-toc](#vim-markdown-toc)
    * [ale](#ale)
        * [linux内核](#linux内核)
        * [cmake工程](#cmake工程)
    * [leaderf](#leaderf)
    * [vim-gutentags](#vim-gutentags)
    * [代码补全](#代码补全)
* [vim实用技巧](#vim实用技巧)
    * [屏蔽插件](#屏蔽插件)
    * [查看启动时间](#查看启动时间)
    * [linux内核tag](#linux内核tag)
    * [tag跳转 — `:tag tag`](#tag跳转--tag-tag)
        * [:ts](#ts)
        * [:tj](#tj)
    * [多文件关闭一个](#多文件关闭一个)
    * [两行合并一行](#两行合并一行)
* [模式行（Modeline）](#模式行modeline)
* [vim/gvim](#vimgvim)
* [参考：](#参考)

<!-- vim-markdown-toc -->

# 安装 VIM9.x

## ubuntu

``` shell
sudo apt install vim universal-ctags cscope global
```
> Version: ubuntu24.04

## Centos7

``` shell
sudo rpm -Uvh http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm
sudo rpm --import http://mirror.ghettoforge.org/distributions/gf/RPM-GPG-KEY-gf.el7
sudo yum --enablerepo=gf-plus install vim-enhanced

sudo yum install vim ctags cscope global
```

## 自动化安装配置

``` shell
wget -q -O - https://gitee.com/winddoing/work_env/raw/master/vim/deploy.sh | bash
```

![vim](./vim.png)

# 插件管理

使用`vim-plug`进行新的插件管理

``` shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```



vim-plug配置项：

| 选项                    | 功能描述                                                     |
| :---------------------- | :----------------------------------------------------------- |
| `branch`/`tag`/`commit` | 所用插件git仓库的Branch/tag/commit                           |
| `rtp`                   | 包含vim插件的子目录                                          |
| `dir`                   | 该vim插件的定制化目录 (Custom directory)                     |
| `as`                    | 给vim插件取别名                                              |
| `do`                    | Post-update hook，某些vim插件在完成安装或更新后，需要执行额外的操作，可以使用 do 选项指定具体的操作或函数 |
| `on`                    | 按需加载: vim命令或`<Plug>`-mappings                         |
| `for`                   | 按需加载: 文件类型                                           |
| `frozen`                | Do not update unless explicitly specified                    |



vim-plug的命令列表：

| 命令                                | 功能描述                                                     |
| :---------------------------------- | :----------------------------------------------------------- |
| `PlugInstall [name ...] [#threads]` | 安装插件                                                     |
| `PlugUpdate [name ...] [#threads]`  | 安装或更新vim插件                                            |
| `PlugClean[!]`                      | 卸装未使用的目录 (bang version will clean without prompt)    |
| `PlugUpgrade`                       | 更新vim-plug自身                                             |
| `PlugStatus`                        | 查看vim插件的状态                                            |
| `PlugDiff`                          | 对比上次PlugUpdate的更改 (Examine changes from the previous update and the pending changes) |
| `PlugSnapshot[!] [output path]`     | 保存当前插件的镜像副本到指定目录 (Generate script for restoring the current snapshot of the plugins) |




# 常用操作


## Fn功能键

|  Fn  | 功能                                 |
| :--: | :----------------------------------- |
|  F2  | doxygen格式的文件注释                |
|  F3  | doxygen格式的函数注释                |
|  F4  | 将当前目录下的目录树                 |
|  F5  | TUML生成                             |
|  F6  | 取消`//`注释，与F7相对               |
|  F7  | 添加`//`注释                         |
|  F8  | 当前的函数和全局变量列表（右侧列出） |
|  F9  | 取消`/* ... */`注释，与F12相对       |
| F10  | 未使用，可留作新功能添加             |
| F11  | 未重定义，为系统全屏                 |
| F12  | 添加`/* ... */`注释                  |


## 快捷键

|      默认快捷键      | 功能                                                       |
| :------------------: | :--------------------------------------------------------- |
|         `0`          | 行首                                                       |
|         `$`          | 行末                                                       |
|         `e`          | 移动到下一个word结尾，不在空行停留                         |
|         `b`          | 移动到上一个word开头                                       |
|         `gf`         | 头文件跳转                                                 |
|         `gd`         | 跳转到局部变量的定义处                                     |
|      `Ctrl + ]`      | 跳转至函数或变量定义处                                     |
|      `Ctrl + t`      | 返回上一次跳转                                             |
|      `Ctrl + o`      | 返回上一次跳转(cscope)                                     |
|      `Ctrl + i`      | 追踪上一次跳转                                             |
|         `~`          | 当前字符切换大小写                                         |
|         `%`          | 跳转到相配对的括号(括号匹配)                               |
|         `"`          | 跳转到光标上次停靠的地方, 是连续两个`'`(键盘1旁边的间隔符) |
|         `{`          | 跳到上一段的开头（不同函数开头）                           |
|         `}`          | 跳到下一段的的开头                                         |
|         `(`          | 移到这个句子的开头                                         |
|         `)`          | 移到下一个句子的开头                                       |
|         `[[`         | 跳转至上一个函数(要求代码块中'{'必须单独占一行)            |
|         `]]`         | 跳转至下一个函数(要求代码块中'{'必须单独占一行)            |
|       `q + :`        | 显示命令行模式中输入的命令的历史记录列表                   |
|       `q + /`        | 显示搜索记录                                               |
|       `ggguG`        | 全文大写转化为小写                                         |
|       `gggUG`        | 全文小写转化为大写                                         |
|       `gU,gu`        | 大小写转换                                                 |
|    `Ctrl + w +w`     | 多编辑窗口切换                                             |
| `Ctrl + w ` `-`\\`+` | 窗口上下调整                                               |
| `Ctrl + w ` `>`\\`<` | 窗口左右调整                                               |
|         `zf`         | 折叠当前选中行                                             |
|        `zf%`         | 折叠当前函数，光标必须放在大括号上                         |
|         `za`         | 打开当前折叠行                                             |
|    `(N)Ctrl + u`     | 窗口向上滚动N行，默认滚动窗口行数的一半。（光标没有移动）  |
|    `(N)Ctrl + d`     | 窗口向下滚动N行，默认滚动窗口行数的一半。（光标没有移动）  |
|    `(N)Ctrl + y`     | 窗口向上滚动N行，默认向上滚动一行。（光标没有移动）        |
|    `(N)Ctrl + e`     | 窗口向下滚动N行，默认向下滚动一行。（光标没有移动）        |
|    `(N)Ctrl + b`     | 窗口向上滚动N页，默认滚动一页。（光标被迫移动）            |
|    `(N)Ctrl + f`     | 窗口向下滚动N页，默认滚动一页。（光标被迫移动）            |
|        `gg=G`        | 全文自动缩进                                               |
|         `==`         | 自动缩进当前行                                             |
|         `x`          | 删除光标处的字符                                           |
|         `X`          | 删除光标前面的字符                                         |
|      `D`或`d$`       | 删除从光标所在处开始到行尾的内容                           |
|         `d0`         | 删除从光标前一个字符开始到行首的内容                       |
|         `dw`         | 删除一个单词                                               |


| 快捷键(自定义)  | 功能                                                         |
| :-------------: | :----------------------------------------------------------- |
|     `xdate`     | 自动输入当前时间(在`插入模式`下输入`xdate`)                  |
|      `xsm`      | unix和dos格式换行符切换                                      |
|      `ds`       | 去除多余空格                                                 |
|      `dh`       | 去除多余空行                                                 |
|      `dm`       | 去除行尾^M                                                   |
| `K (Shift + k)` | 函数man查找                                                  |
|      `df`       | 添加应用层打印(debug printf) `printf("===> func: %s, line: %d\n", __func__, __LINE__);` |
|      `dff`      | 添加应用层打印`printf("===> func: %s, line: %d, file: %s\n", __func__, __LINE__, __FILE__);` |
|      `dk`       | 添加内核打印(debug printk)`printk("===> func: %s, line: %d\n", __func__, __LINE__);` |
|      `lf`       | 等价于F8                                                     |
|      `ld`       | 等价于F4                                                     |
|      `xml`      | 格式化xml文件                                                |
|     `json`      | 格式化json文件                                               |
|      `216`      | 转为十六进制显示                                             |
|      `lt`       | 显示Tab指示线                                                |
|      `ww`       | 多编辑窗口切换                                               |
|      `++`       | 上下窗口上移                                                 |
|      `--`       | 上下窗口下移                                                 |
|      `<<`       | 左右窗口左移                                                 |
|      `>>`       | 左右窗口右移                                                 |
|      `gb`       | 查看当前行代码的提交记录                                     |
| `<leader> + k`  | 不同颜色高亮当前单词                                         |
| `<leader> + kk` | 取消所有不同颜色高亮                                         |
|   `ctrl + b`    | 垂直方向上打开一个终端                                       |


> 额外的功能组合键：`<leader> = ；`

```
let mapleader = ";"
```

## ctags

按键跳转Ctrl-],Ctrl-t,Ctrl-o
在创建tags文件的目录下，用vim打开的文件中，光标移到一个被调用的函数名上，按Ctrl-]就会自动跳转到该函数的定义处，Ctrl-t返回。

命令跳转
```
:tags  functionname
```
在用vim打开的文件中，用命令:tags  functionname。:ta functionname

打开时搜索并跳转
```
vim -t functionname
```
多个匹配tags时跳转
```
:tnext，:tprev，:tn,:tp
```

## cscope

```
cscope commands:
add  : Add a new database             (Usage: add file|dir [pre-path] [flags])
find : Query for a pattern            (Usage: find c|d|e|f|g|i|s|t name)
       c: Find functions calling this function
       d: Find functions called by this function
       e: Find this egrep pattern
       f: Find this file
       g: Find this definition
       i: Find files #including this file
       s: Find this C symbol
       t: Find this text string
help : Show this message              (Usage: help)
kill : Kill a connection              (Usage: kill #)
reset: Reinit all connections         (Usage: reset)
show : Show connections               (Usage: show)
```

|   参数   | 快捷键 | 功能                             |
| :------: | :----: | :------------------------------- |
| `0`or`s` | `<leader> + s`  | 查找这个C符号                    |
| `1`or`g` | `<leader> + g`  | 查找这个定义                     |
| `2`or`d` | `<leader> + d`  | 查找被这个函数调用的函数（们）   |
| `3`or`c` | `<leader> + c`  | 查找调用这个函数的函数（们）     |
| `4`or`t` | `<leader> + t`  | 查找这个字符串                   |
| `6`or`e` | `<leader> + e`  | 查找这个egrep匹配模式            |
| `7`or`f` | `<leader> + f`  | 查找这个文件                     |
| `8`or`i` | `<leader> + i`  | 查找#include这个文件的文件（们） |





## 字符串替换

```
:[range]s/from/to/[flags]
```
- `range`: 搜索范围，如果没有指定范围，则作用于但前行, `%`表示在所有行中搜索替换
- `flags`:
- `c`: confirm，每次替换前询问
- `e`: error，不显示错误
- `g`: globle，不询问，整行替换
- `i`: ignore，忽略大小写


## 标记-Mark

标记的跳转可以跨文件

### 添加标记

```
m[0~9|a~z|A~Z]
```
|  标注   | 设置者  | 使用                                                         |
| :-----: | :-----: | :----------------------------------------------------------- |
| `a`-`z` |  用户   | 仅对当前的一个文件生效，也就意味着只可以在当前文件中跳转     |
| `A`-`Z` |  用户   | 全局标注，可以作用于不同文件。大写标注也称为「文件标注」。跳转时有可能会切换到另一个缓冲区 |
| `0`-`9` | viminfo | 0 代表 viminfo 最后一次被写入的位置。实际使用中，就代表 Vim 进程最后一次结束的位置。1 代表 Vim 进程倒数第二次结束的位置，以此类推 |

### 跳转标记

```
`{mark}
```

### 查看标记

```
:marks
```

系统内置的特殊标记

| 标记  | 作用                   |
| :---: | :--------------------- |
|  `.`  | 最近编辑的位置         |
| `0-9` | 最近使用的文件         |
|  `^`  | 最近插入的位置         |
|  \`   | 上一次跳转前的位置     |
|  `"`  | 上一次退出文件时的位置 |
|  `[`  | 上一次修改的开始处     |
|  `]`  | 上一次修改的结尾处     |


### 删除标记

```
::delmarks a b c
```
> 删除单个或多个标记

```
:delmarks!
```
> 删除所有标记mark


## 文件对比

```
vimdiff a1 a2
```
`do`: 将当前窗口光标位置处的内容复制到另一窗口
`dp`: 将另一窗口光标位置处的内容复制到当前窗口
`]c`: 跳转到下一个diff点
`[c`: 跳转到前一个diff点

## 符号对齐

先用v选择多行, `ga`进入easyalign模式, 默认`向左对齐`

### 等号对齐

1. 选中需要对齐的文本（Ctrl-V）
2. `ga + =`

### 空格对齐

1. 选中需要对齐的文本（Ctrl-V）
2. `ga + <space>`



## session会话

如果在vim中已经打开了好多窗口，想要保持这个环境，等下次编辑浏览时再载入，可以使用session会话来完成

```
:help mksession  查看mksession的帮助
:mksession!      保存当前的vim状态，在当前目录会产生一个会话文件Session.vim，其中！表示强制
或者
:mks!
$vim -S          vim会自动载入当前目录的会话文件Session.vim，之前:mksession!保持的状态又回来啦。
```



### 自动加载恢复

当前vimrc中配置了自动加载恢复会话的功能，但是在**第一次使用时需要将保存的会话重命名为project.vim**

```
:mks! project.vim
```

- 恢复

  直接执行vim不带任何参数，即可根据project.vim文件恢复之前保存的会话状态。

- 保存

  只有存在project.vim文件，并且是直接用vim恢复的会话，在退出时会自动保存将状态到project.vim文件中



## 拷贝系统剪切板

```shell
sudo apt install vim-gtk
```

操作命令：

- `+y`：复制
- `+p`：粘贴

复制到系统剪切板，并提供Ctrl+v进行粘贴`"+y`(操作即先按住Shift后按引号 “、加号+，松开Shift后按y)


## vim中使用grep

vim中输入以下命令进行查找，使用系统grep

```
:grep xxx -r dir/sub_dir
```

然后打开quickfix可以查看和切换

```
:copen
```

不需要时可以将其关闭

```
:cclose
```

## 将文档中同一字符串转为大写

进入命令模式，按下

```
:%s/要转换的字符串/\U&/g
```



## 匹配数字，进行运算，使用运算结果替换

```
:%s/ \(\d\d\)/\=(submatch(1)+32)/gc
```

\(\d\d\)表示匹配2个连续数字, submatch(1) 表示调用第一个括号匹配的字符，使用数字计算结果时，使用\=表示计算结果、



## 其他

### 多个标签切换

`aa`  下一个标签

`zz`  上一个标签


### 十六进制显示

```
:%!xxd
```
# 修改配置

## 代码注释颜色

``` C
hi Comment         ctermfg=49
```

# 插件使用

创建管理`vim-plug`

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## vim-markdown-toc

生成目录

```
:GenTocGFM
```

更新目录

```
:UpdateToc
```



## ale

语法检测，依赖`clang`，目前配置只在保存（:w）时进行语法检测。

在实际使用中总是报找不到头文件的错误主要原因是没有生成`compile_commands.json`文件


### linux内核

运行以下脚本自动生成
```
./scripts/clang-tools/gen_compile_commands.py
```
或
```
make compile_commands.json
```

### cmake工程

在CMakeLists.txt中添加:
```
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```

## leaderf

模糊查找文件

快捷键：`Ctrl + p`


## vim-gutentags

- 安装
```
sudo apt install global python3
```
> gtags依赖python3环境，因此也需要安装python3, `/usr/share/global/gtags/script/pygments_parser.py`

- `g:gutentags_project_root`: 确定当前文件所属的项目目录，会从当前文件所在目录开始向父目录递归，直到找到这些标志文件。如果没有，则gutentags认为该文件是个野文件，不会帮它生成ctags/gtags数据
 - 如果你的项目不在 svn/git/hg 仓库中的话，可以在项目根目录 touch 一个空的名为`.root`的文件即可



## 代码补全



```
# vim9中启动存在异常
Plug 'girishji/vimcomplete'

# 轻量级，不要过多配置
Plug 'jayli/vim-easycomplete'
Plug 'SirVer/ultisnips'

# 这个比较麻烦
Plug 'neoclide/coc.nvim', {'branch': 'release'}
```

| 插件             | 功能              | 说明                                 |
| ---------------- | ----------------- | ------------------------------------ |
| coc.vim          | 极高，LSP         | 占用资源多                           |
| vim-easycomplete | 高，LSP           | 使用简单，异步补全                   |
| vimcomplete      |                   | 配置后无法自动弹出补全框             |
| vim-mucomplete   | 低（原生），无LSP | 占用资源少,不是异步补全不好用,太慢了 |



### YCM

依赖软件：

```shell
sudo apt install python3-dev python3-pip build-essential git cmake python3-dev clang clangd
```

> ubuntu24.04

通过`:PlugInstall`安装完后无法补全可能是安装过程中编译失败导致的，可以手动重新编译。

编译：

```shell
cd plugged/YouCompleteMe/
./install.py --clang-completer
proxychains ./install.py --clang-completer
```

正常编译完成后，还是无法自动补全？

```
NoExtraConfDetected: No .ycm_extra_conf.py file detected, so no compile flags are available. Thus no semantic support for C/C++/ObjC/ObjC++. Go READ THE DOCS *NOW*, DON'T file a bug report.
```

添加配置：

```
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
```



#### **`compile_commands.json`**

Clangd/YCM 会自动读取项目根目录下的 `compile_commands.json`，无需手动配置头文件路径。

```shell
# CMake 项目
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .

# Make 项目（需安装 compiledb）
pip3 install compiledb
compiledb make

# Linux内核
./scripts/clang-tools/gen_compile_commands.py

# bear配合make生成
bear -- make -j`nproc`
```

> [Linux kernel生成compile_commands.json](#Linux kernel生成compile_commands.json)



#### 获取系统头文件路径

```shell
echo | clang -v -E -x c++ -

echo | clang -v -E -x c -
```



### ubuntu下apt安装

> 未测试，下次可以试试

如果你使用一个较新的 Linux 发布版，有可能系统本身已经自带了 YCM。虽然这个版本多半会有点老，但对于有些人来说，可能也够用了。毕竟，Linux 下的包安装确实方便。我们就先以 Ubuntu 为例，来介绍 Linux 包管理器下的安装过程。

首先，我们需要使用 apt 命令来安装 YCM，命令是：

```undefined
sudo apt install vim-youcompleteme
```

这步成功之后，YCM 就已经被安装到了你的系统上。不过，在你个人的 Vim 配置里，仍然还没有启用 YCM。要启用的话，可以输入下面的命令：

```undefined
vim-addon-manager install youcompleteme
```

这个命令之后，你会在你的 ~/.vim/plugin 目录下看到 youcompleteme.vim 的符号链接。这样，安装就算完成了。



- [13 YouCompleteMe：Vim 里的自动完成](https://learn.lianglianglee.com/%E4%B8%93%E6%A0%8F/Vim%20%E5%AE%9E%E7%94%A8%E6%8A%80%E5%B7%A7%E5%BF%85%E7%9F%A5%E5%BF%85%E4%BC%9A/13%20YouCompleteMe%EF%BC%9AVim%20%E9%87%8C%E7%9A%84%E8%87%AA%E5%8A%A8%E5%AE%8C%E6%88%90.md)



# vim实用技巧

## 屏蔽插件

```
alias vi='vim --noplugin'
```

## 查看启动时间

```
vim --startuptime timefile test.c
```



## linux内核tag

```
make SUBARCH=arm64 SRCARCH=arm64 COMPILED_SOURCE=1 tags cscope
```

> make执行的脚本文件内核目录下`scripts/tags.sh`



## tag跳转 — `:tag tag`

由于使用`vim-gutentags`自动生成tags数据库，导致`vim -t tag`命令无法使用。

为了方便对特定函数的跳转在vim中可以使用`:ts tag`或`：tj tag`,也可以使用`:tag tag`

### :ts

> 列出符号x的定义

```
                                                        :ts :tselect
:ts[elect][!] [name]    List the tags that match [name], using the
                        information in the tags file(s).
                        When [name] is not given, the last tag name from the
                        tag stack is used.
                        See tag-! for [!].
                        With a '>' in the first column is indicated which is
                        the current position in the list (if there is one).
                        [name] can be a regexp pattern, see tag-regexp.
                        See tag-priority for the priorities used in the
                        listing.
```

### :tj

> 如果只找到一个符号定义，那么直接跳转到符号定义处，如果有多个，则全部列出让用户自行选择

```
                                                        :tj :tjump
:tj[ump][!] [name]      Like ":tselect", but jump to the tag directly when
                        there is only one match.
```

## 多文件关闭一个

切换到想关闭的文件窗口，输入`:bd`，即可关闭

> bd: buffers delete

## 两行合并一行

操作快捷键大写`J`，也就是`shift+j`



# 模式行（Modeline）

制表符常常有不同的偏好，有的使用8个空格，而有的则使用4个空格。可以想见，如果使用不同设置的用户操作相同的文件，必将对文本格式造成影响。

如果希望针对特定文件应用特定的设置，那么修改全局性的vimrc配置文件就显得小题大做了；而使用模式行(modeline)，则可以将选项设置配置在文件本身当中。

```
/* vim:set tabstop=4: */
```

tab占4个空格

```
/* vim:tabstop=4:expandtabs:shiftwidth=4 */
```



# vim/gvim

```
set number
"禁止生成undofile文件和备份文件
set noundofile
set nobackup
set noswapfile
```





# Linux kernel生成compile_commands.json



在使用YCM插件时，为了在linux内核中代码补全数据结构更准确，需要生成compile_commands.json文件，生成方式有两种：

- 通过bear命令在编译时生成（bear -- make -j8）
- 通过./scripts/clang-tools/gen_compile_commands.py脚本生成



通过以上两种方式生成的compile_commands.json文件在使用过程中可以补全，但是不是结构体成员中的字段也会提示，很不好用，`:YcmDebugInfo`查看日志有以下错误：



## Failed to prepare a compiler instance: unknown target ABI 'lp64'

解决方法：

在linux内核源码的根目录创建一个`.clangd`的文件，然后在文件里写入如下内容：

```json
CompileFlags:
    Remove: -mabi=lp64
```

```shell
# 也可以之间将保存的配置文件拷贝到内核的根目录下
cp ~/.vim/other/linux_kernel_clangd.cfg .clangd
```





# 参考：

1. [像 IDE 一样使用 vim](https://github.com/yangyangwithgnu/use_vim_as_ide)
2. [130+ Essential Vim Commands](https://catswhocode.com/vim-commands/)
3. [after/ftplugin/sh.vim](https://jnrowe-vim.readthedocs.io/after/ftplugin/sh.html)
3. [vim进阶:200个终身受益的命令](https://mp.weixin.qq.com/s?__biz=MzkxNDUxNjI5MQ==&mid=2247486057&idx=1&sn=42078fd934aa5a232f12724c2581ec8c&chksm=c16c7a45f61bf353a3b4dbf3ad59dd7b272f1777887a04a45e918bb8ced377d00adf909b43b8&cur_album_id=3369454863339978752&scene=189#wechat_redirect)
