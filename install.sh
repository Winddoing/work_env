##########################################################
# File Name		: install.sh
# Author		: wqshao
# Created Time	: 2017年03月12日 星期日 09时45分53秒
# Description	:
##########################################################
#!/bin/bash

PWD=`pwd`
user=$USER
home=$HOME

no_sudo="no_sudo"
NO_SUDO="$1"

function install_cmd()
{
	local cmd=$1
	#ubuntu
	echo "sudo apt-get install $cmd ..."
	sudo apt-get install $cmd
}

function which_command()
{
	local cmd=$1

	command -v $cmd >> /dev/null
	if [ $? -ne 0 ]; then
		echo "   Need Install $cmd ...\n"
		if [ x$no_sudo != x$NO_SUDO ]; then
			install_cmd $cmd
		fi
	fi
}

function install_vim()
{
	local source_file="$home/.vim"
	local config_file="$home/.vimrc"

	which_command vim
	echo "Vim version `vim --version | awk 'NR==1'`"

	if [ ! -L $source_file ]; then
		ln -s $PWD/vim $source_file
		echo xxxxxxxxxxxxxx
	fi
	if [ ! -L $config_file ]; then
		ln -s $PWD/vim/vimrc $config_file
	fi
}

function install_git()
{
	which_command git
	echo "Git version `git --version`"

	git config --global user.name  "winddoing"
	git config --global user.email "winddoing@sina.cn"
	# 别名
	git config --global alias.co checkout
	git config --global alias.ci commit
	git config --global alias.st status
	git config --global alias.br branch
	git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
	git config --global alias.type 'cat-file -t'
	git config --global alias.dump 'cat-file -p'
	# 颜色
	git config --global color.diff auto
	git config --global color.status auto
	git config --global color.branch auto
	git config --global color.interactive auto
	# 编辑器
	git config --global core.editor vim
	# 4空格缩进
	git config --global core.pager 'less -x1,5'
	# 去掉git提交时出现很多^M提示符
	git config --global core.whitespace  cr-at-eol
	# 关闭中文文件名或者路径被转义
	git config --global core.quotepath false
	# 图形界面编码
	git config --global gui.encoding utf-8
	# 提交信息编码
	git config --global i18n.commitencoding utf-8
	# 输出log编码
	git config --global i18n.logoutputencoding utf-8
	# 合并工具
	git config --global merge.tool meld
	# 临时将密码存储在内存中,默认有效时间900s，15分钟
	git config --global credential.helper cache
	# 调整http提交文件大小为100M，默认为1M
	git config --global http.postBuffer 100M
	# commit模板
	git config --global commit.template $PWD/git/gitmessage
}

function install_tmux()
{
	local config_file="$home/.tmux.conf"
	local version=`tmux -V | awk '{print int($2)}'`

	which_command tmux
	echo "Tmux version `tmux -V` [$version]"

	if [ ! -L $config_file ]; then
		if [ "$version" -gt "1" ]; then # v < 1
			ln -sf $PWD/tmux/tmux.conf $config_file
		else
			ln -sf $PWD/tmux/tmux2.0_before.conf $config_file
		fi
	fi
}

function bash_add_config()
{
	local bashrc="$home/.bashrc"
	local bashrc_bak="$home/.bashrc_bak"
	local config_bashrc="$home/.config_bashrc"
	local keyword="Winddoing"

	echo "$bashrc, $config_bashrc"

	if [ ! -f $bashrc_bak ]; then
		echo "$user backup <$bashrc> file to <$bashrc_bak>"
		cp $bashrc $bashrc_bak
	fi

	grep "$keyword" $bashrc >> /dev/null
	if [ $? -eq 0 ]; then
		return 1;
	fi

	cat $config_bashrc >> $bashrc
}

function install_bash()
{
	local config_file="$home/.config_bashrc"
	local config_file_set="$home/.custom_bashrc"
	local custom_cmd_file="$home/.custom_cmd"

	if [ ! -L $config_file ]; then
		ln -s $PWD/bash/config_bashrc $config_file
	fi
	if [ ! -L $config_file_set ]; then
		ln -s $PWD/bash/custom_bashrc $config_file_set
	fi
	if [ ! -L $custom_cmd_file ]; then
		ln -s $PWD/bash/custom_cmd $custom_cmd_file
	fi

	bash_add_config
}

function install_tools()
{
	local source_file="$home/.tools"

	if [ ! -L $source_file ]; then
		ln -s $PWD/tools/ $source_file
	fi
}

function main()
{
	install_bash
	install_tools

	install_vim
	install_git
	install_tmux
}

# start

if [ x$no_sudo != x$NO_SUDO ]; then
	sudo -l
fi

if [ $? -eq 0 ]; then
	main
fi


