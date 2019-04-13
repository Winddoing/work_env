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

install_success_i=0
install_failed_i=0

LINUX_BASEL_SOFTWARE=(git git-extras tig vim tmux exuberant-ctags cscope doxygen
    openssh-server samba smbclient htop gcc g++ make cmake net-tools graphviz
    tree colordiff subversion tftpd tftp xinetd sshfs minicom adb astyle splint
    cloc sparse fakeroot icdiff)

LINUX_GRAPH_SOFTWARE=(gitk meld eog cutecom deepin-screenshot atom firefox vlc
    kolourpaint rapidsvn thunderbird)

LINUX_OTHER_SOFTWARE=(dia filezilla stardict virtualbox spatialite-gui wireshark
    sqlitebrowser audacity vooya)

function install_software()
{
    name=$1[@]
    slist=("${!name}")

    for software in "${slist[@]}"
    do
        echo -ne "Install software [\033[33m$software\033[0m] ... "
        sudo apt-get install -y $software > $output 2>&1
        if [ $? -ne 0 ]; then
            echo -e "\033[31mfail\033[0m"
            install_failed_i=$(($install_failed_i+1))
        else
            echo -e "\033[32msuccess\033[0m"
            install_success_i=$(($install_success_i+1))
        fi

        trap "print_count" INT
    done
}

function software_install()
{
    install_software LINUX_BASEL_SOFTWARE
    install_software LINUX_GRAPH_SOFTWARE
    install_software LINUX_OTHER_SOFTWARE
}

function print_count()
{
    local all_num
    all_num=$((${#LINUX_BASEL_SOFTWARE[@]} + ${#LINUX_GRAPH_SOFTWARE[@]} + ${#LINUX_OTHER_SOFTWARE[@]}))

    echo ""
    echo "Install success software: $install_success_i"
    echo "Install fail software: $install_failed_i"
    echo ""
    echo "Total number of software: $all_num"
    echo "Not Installed software: $(($all_num - $install_failed_i - $install_success_i))"
    exit 1;
}

# main
sudo -l

echo "TTY: $output"
software_install
print_count

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

# Java eclipse
# 软件商店搜索安装

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
# sudo apt inatsll deepin-screenshot

# 画图软件
# sudo apt install kolourpaint

# yuv播放器
# sudo apt install vooya

# SVN
# sudo apt install rapidsvn
