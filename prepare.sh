##########################################################
# File Name		: prepare.sh
# Author		: wqshao
# Created Time	: 2018年05月07日 星期一 19时30分14秒
# Description	:
##########################################################
#!/bin/bash

# 去掉注释恢复打印
#debug="x"

if [ x$debug != "x" ]; then
	output=`tty`
else
	output="/dev/null"
fi

trap 'echo "Ctrl+c interrupted!"; exit' INT

install_all_num=0
install_success_i=0
install_failed_i=0

INSTALL_CMD=apt
LINUX_INSTALL_CMD=(apt-get apt yum)

LINUX_BASEL_CORE_SOFTWARE=(git git-extras tig
	vim universal-ctags cscope global python3 python-is-python3 doxygen graphviz
	htop sysstat
	gcc g++ make cmake
	openssh-server net-tools tmux tree colordiff astyle)

LINUX_GRAPH_CORE_SOFTWARE=(gitk meld eog vlc kolourpaint flameshot thunderbird
	goldendict virtualbox virtualbox-ext-pack gnome-calculator)

LINUX_BASEL_EXT_SOFTWARE=(samba smbclient tftpd tftp sshfs minicom adb splint
	cloc sparse fakeroot icdiff indent tldr cpustat cpufrequtils
	linux-tools-generic read-edid edid-decode speedtest-cli
	screenfetch mediainfo)

LINUX_GRAPH_EXT_SOFTWARE=(remmina remmina-plugin-spice gparted okular firefox zeal)

#LINUX_OTHER_SOFTWARE=(sqlitebrowser audacity wireshark apitrace)
LINUX_OTHER_SOFTWARE=(audacity wireshark)

LINUX_SYSTEM_GNOME_SOFTWARE=(gnome-icon-theme gnome-tweaks)

LINUX_3RD_PARTY_SOFTWARE=(typora vooya freedownloadmanager obsidian draw.io)

function install_software()
{
	name=$1[@]
	slist=("${!name}")
	num=${#slist[@]}
	cnt=1

	echo "Install $1 Total: $num"
	for software in "${slist[@]}"
	do
		echo -ne "Install software[$cnt/$num] [\033[33m$software\033[0m] ... "
		sudo $INSTALL_CMD install -y $software > $output 2>&1
		if [ $? -ne 0 ]; then
			echo -e "\033[31mfail\033[0m"
			install_failed_i=$(($install_failed_i+1))
		else
			echo -e "\033[32msuccess\033[0m"
			install_success_i=$(($install_success_i+1))
		fi
		cnt=$(($cnt+1))
		install_all_num=$(($install_all_num + 1))

		trap "print_count" INT
	done
}

function software_install()
{
	install_software LINUX_BASEL_CORE_SOFTWARE
	install_software LINUX_GRAPH_CORE_SOFTWARE

	#install_software LINUX_BASEL_EXT_SOFTWARE
	#install_software LINUX_GRAPH_EXT_SOFTWARE
	#install_software LINUX_OTHER_SOFTWARE
	#install_software LINUX_SYSTEM_GNOME_SOFTWARE
	#install_software LINUX_3RD_PARTY_SOFTWARE
}

function print_count()
{
	echo ""
	echo "Install success software: $install_success_i"
	echo "Install fail software: $install_failed_i"
	echo ""
	echo "Total number of software: $install_all_num"
	echo "Not Installed software: $(($install_all_num - $install_failed_i - $install_success_i))"
	exit 1;
}

function out() {
	echo -e "\e[01;31m$@ \e[0m"
}

function select_install_cmd()
{
	cmdarray=$1[@]
	cmdlist=("${!cmdarray}")

	for cmd in "${cmdlist[@]}"
	do
		#echo "Install select $cmd"
		which $cmd > $output 2>&1
		if [ $? -eq 0 ]; then
			INSTALL_CMD=$cmd
		fi
	done
}

function sys_update()
{
	out "apt Update"
	sudo apt update
	out "apt Upgrade"
	sudo apt upgrade
	out "apt Autoremove"
	sudo apt autoremove
	out "apt Autoclen"
	sudo apt autoclean
}

# main
sudo -l

echo "TTY: $output"
select_install_cmd LINUX_INSTALL_CMD
echo -e "Current Install cmd [\033[31m$INSTALL_CMD\033[0m]"
sys_update
software_install
print_count

# 图形界面的FTP客户端
# sudo apt install filezilla

# HexEdit是一款十六进制编辑器
# sudo apt install hexedit
# sudo apt install ghex #图形

# 数据库编辑
# spatialite-gui
# sudo apt install sqlitebrowser(好用)

# 网络包分析
# sudo apt-get install wireshark

# chm文件阅读器
# sudo apt-get install kchmviewer

# epub电子书阅读器
# sudo apt install calibre

# C语言静态语法检测
# sudo apt install splint

# 代码统计
# sudo apt install cloc

# C代码静态检查工具
# sudo apt install sparse

# 串口助手
# sudo apt install cutecom

# 截图软件
# sudo apt inatsll flameshot

# 画图软件
# sudo apt install kolourpaint

# yuv播放器
# sudo apt install vooya

# SVN
# sudo apt install rapidsvn

# 任务管理和性能监控工具
# sudo apt install ksysguard

# 可视化显示Linux内存使用情况
# sudo apt install smem

# markdown编辑器
# sudo apt install typora
# https://github.com/iuxt/src/releases/download/2.0/Typora_Linux_0.11.18_amd64.deb

# 录屏软件
# sudo apt install simplescreenrecorder

# 跨平台局域网传输文件
# sudo apt install nitroshare

# X86软件逆向工具
# sudo apt install edb-debugger

# 系统资源监控工具
# sudo apt install glances

# 3D赛车游戏
# sudo apt install torcs
# sudo apt install supertuxkart

# 测网速
# sudo apt install speedtest-cli

# 远程桌面
# sudo apt install xrdp tightvncserver

# 便签
# sudo apt install xpad

# 飞鸽传书
# sudo apt install iptux

# 命令行的交互式绘图工具
# sudo apt install gnuplot

# chrome浏览器
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# 各种语言的离线文档
# sudo apt install zeal

# windows字体
# sudo apt install ttf-mscorefonts-installer

# 日志分析工具 (https://github.com/variar/klogg)
# sudo apt install klogg

# wiki笔记工具, 中文界面Exec=env LANGUAGE=zh_CN zim %f
# sudo apt install zim
