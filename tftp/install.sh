##########################################################
# File Name		: install.sh
# Author		: wqshao
# Created Time	: 2018年05月08日 星期二 15时34分02秒
# Description	:
##########################################################
#!/bin/bash

set -x

PWD=`pwd`
user=$USER
home=$HOME


sudo apt-get install tftpd tftp xinetd


mkdir $home/tftprootfs
sudo chmod 777 $home/tftprootfs -R

sudo cp tftp  /etc/xinetd.d

sudo systemctl restart xinetd.service



