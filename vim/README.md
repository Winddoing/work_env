# 安装 VIM8.x

```
sudo apt-get install vim
```
> Version: ubuntu18.04


# 插件安装

在已有插件的基础上使用`vundle`进行新的插件管理

进入vi执行：
``` shell
:PluginInstall
```


# 常用操作


## Fn功能键

### F2
doxygen格式的文件注释
```
/**
 * @file README.md
 * @brief  /
 * @author xxxx, xxxxxxxxx@xxx.com
 * @version 1.0
 * @date 2017-02-26
 */
```
### F3

doxygen格式的函数注释
```
/**
 * @brief  main /
 *
 * @param argv
 * @param argc[]
 *
 * @returns
 */
int main(int argv, char* argc[])

```
### F4

将当前目录下的目录树

### F5

TUML生成

### F6

取消`//`注释，与F7相对

### F7

添加`//`注释

```
//int main(int argv, char* argc[])
```
### F8

当前的函数和全局变量列表（右侧列出）

### F9

取消`/* ... */`注释，与F12相对

### F10

未使用，可留作新功能添加

### F11

未重定义，为系统全屏

### F12

添加`/* ... */`注释

## 文件查找

额外的功能组合键：`；`

```
let mapleader = ";"
let g:mapleader = ";"
```
### 模糊搜索

```
Ctrl + p
```
### 已编辑文件搜索

```
; +f
```

## 快捷键

### 去除多余空格

```
ds
```
### 行首

```
LB
```

### 行末

```
LE
```

## 头文件跳转

```
gf
```

## 函数man查找

```
K (Shift + k)
```

### 多编辑框切换

双击`w`

### 直接退出

```
qq
```

## 窗口调整

### 上下

大：`+`, 小：`-`

### 左右

大：`>`, 小: `<`

## 其他

### `末行模式`重定义空格

为了搜索方便，此时`空格`相当于`/`

### 自动输入当前时间

在`插入模式`下输入`xdate`


### 多个标签切换

`aa`  下一个标签

`zz`  上一个标签

### 行号

`11` 去除行号

`22` 显示行号


### 十六进制显示

```
:%!xxd
```
### ctags

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
# 修改配置

## 代码注释颜色

``` C
hi Comment         ctermfg=49
```

##  :highlight 

# 插件安装


# 参考：

1. [像 IDE 一样使用 vim](https://github.com/yangyangwithgnu/use_vim_as_ide)
