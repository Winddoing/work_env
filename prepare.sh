##########################################################
# File Name		: prepare.sh
# Author		: wqshao
# Created Time	: 2018年05月07日 星期一 19时30分14秒
# Description	:
##########################################################
#!/bin/bash

LINUX_BASEL_SOFTWARE="git vim tmux exuberant-ctags doxygen openssh-server
	samba smbclient htop gcc g++ make cmake net-tools graphviz tree colordiff
	subversion tftpd tftp xinetd sshfs minicom adb"

LINUX_GRAPH_SOFTWARE="gitk meld eog"

LINUX_OTHER_SOFTWARE="dia filezilla stardict virtualbox spatialite-gui sqlitebrowser"

function install_software()
{
	for software in $1
	do
		echo "Install software $software ..."
		sudo apt-get install -y $software
	done
}

function software_install()
{
	install_software "${LINUX_BASEL_SOFTWARE}"
	install_software "${LINUX_GRAPH_SOFTWARE}"
	install_software "${LINUX_OTHER_SOFTWARE}"
}

# main
sudo -l

software_install

# 邮箱
# sudo apt-get install thunderbird

# mail: Evolution

# BT下载工具
# sudo apt install ktorrent

# 图形界面的FTP客户端
# sudo apt install filezilla

# HexEdit是一款十六进制编辑器
# sudo apt install hexedit

# 数据库编辑
# spatialite-gui
# sudo apt install sqlitebrowser(好用)

# 网络包分析
# sudo apt-get install wireshark

# chm文件阅读器
# sudo apt-get install kchmviewer
