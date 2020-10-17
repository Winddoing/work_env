#!/bin/bash
##########################################################
# File Name		: system_cleanup.sh
# Author		: winddoing
# Created Time	: 2020年05月19日 星期二 16时00分54秒
# Description	:
##########################################################

set -x

# 删除系统不再使用的孤立软件
sudo apt-get autoremove

# 清理旧版本的软件缓存
sudo apt-get autoclean

# 清除残余的配置文件
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P



# 查看所有内核
dpkg --get-selections|grep linux

# 删除无用内核
#sudo apt-get purge linux-image-4.15.0*



# 查看有没有多余的库
deborphan -sPz

# 清除多余的库
sudo apt-get remove --purge `deborphan`
