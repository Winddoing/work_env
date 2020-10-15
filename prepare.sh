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

INSTALL_CMD=apt
LINUX_INSTALL_CMD=(apt-get apt yum)

LINUX_BASEL_SOFTWARE=(git git-extras tig vim tmux exuberant-ctags cscope doxygen
    openssh-server samba smbclient htop gcc g++ make cmake net-tools graphviz
    tree colordiff subversion tftpd tftp xinetd sshfs minicom adb astyle splint
    cloc sparse fakeroot icdiff indent cgdb tldr repo
    cpustat cpufrequtils linux-tools-generic apitrace read-edid
    edid-decode speedtest-cli sysstat screenfetch)

LINUX_GRAPH_SOFTWARE=(gitk meld eog deepin-screenshot firefox vlc
    kolourpaint thunderbird ksysguard gnome-tweaks remmina gparted
    fcitx-bin fcitx-table okular)

LINUX_OTHER_SOFTWARE=(filezilla virtualbox sqlitebrowser audacity)

LINUX_3RD_PARTY_SOFTWARE=(adobe-flashplugin browser-plugin-freshplayer-pepperflash
    atom typora vooya)

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

        trap "print_count" INT
    done
}

function software_install()
{
    install_software LINUX_BASEL_SOFTWARE
    install_software LINUX_GRAPH_SOFTWARE
    install_software LINUX_OTHER_SOFTWARE
    install_software LINUX_3RD_PARTY_SOFTWARE
}

function print_count()
{
    local all_num
    all_num=$((${#LINUX_BASEL_SOFTWARE[@]} + ${#LINUX_GRAPH_SOFTWARE[@]} \
        + ${#LINUX_OTHER_SOFTWARE[@]} + ${#LINUX_3RD_PARTY_SOFTWARE[@]}))

    echo ""
    echo "Install success software: $install_success_i"
    echo "Install fail software: $install_failed_i"
    echo ""
    echo "Total number of software: $all_num"
    echo "Not Installed software: $(($all_num - $install_failed_i - $install_success_i))"
    exit 1;
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
    sudo $INSTALL_CMD update
    sudo $INSTALL_CMD upgrade
    sudo $INSTALL_CMD autoremove
    sudo $INSTALL_CMD autoclean
}

# main
sudo -l

echo "TTY: $output"
select_install_cmd LINUX_INSTALL_CMD
echo -e "Current Install cmd [\033[31m$INSTALL_CMD\033[0m]"
sys_update
software_install
print_count

# 邮箱
# sudo apt-get install thunderbird

# mail: Evolution

# BT下载工具
# sudo apt install ktorrent

# ed2k下载工具——MSDN
# sudo apt install amule
# https://dn3.freedownloadmanager.org/6/latest/freedownloadmanager.deb

# 图形界面的FTP客户端
# sudo apt install filezilla

# HexEdit是一款十六进制编辑器
# sudo apt install hexedit
# sudo apt install wxhexeditor #图形

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

# 任务管理和性能监控工具
# sudo apt install ksysguard

# 可视化显示Linux内存使用情况
# sudo apt install smem

# markdown编辑器
# sudo apt install typora

# 录屏软件
# sudo apt install simplescreenrecorder

# 画板
# sudo apt install mypaint

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

