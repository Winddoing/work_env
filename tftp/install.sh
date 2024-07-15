##########################################################
# File Name		: install.sh
# Author		: wqshao
# Created Time	: 2018年05月08日 星期二 15时34分02秒
# Description	:
##########################################################
#!/bin/bash


PWD=`pwd`
user=$USER
home=$HOME

TFTP_DIR="$home/share/tftp"

install_old_tftpd()
{
	echo "$FUNCNAME: TFTP_DIR=$TFTP_DIR"

	sudo apt install tftpd tftp xinetd

	if [ ! -d $TFTP_DIR ]; then
		mkdir -p $TFTP_DIR
	fi
	sudo chmod 777 $TFTP_DIR -R

	sudo bash -c "cat > /etc/xinetd.d/tftp" <<EOF
service tftp
{
    protocol        = udp
    socket_type     = dgram
    wait            = yes
    user            = root
    server          = /usr/sbin/in.tftpd
    server_args     = -s $TFTP_DIR
    disable         = no
    per_source      = 11
    cps             = 100 2
    flags           = IPv4
}
EOF

	sudo systemctl restart xinetd.service
}


insatll_hpa_tftpd()
{
	echo "$FUNCNAME: TFTP_DIR=$TFTP_DIR"
	local tftpd_conf="/etc/default/tftpd-hpa"

	sudo apt install tftpd-hpa tftp-hpa

	if [ ! -f /etc/default/tftpd-hpa.bak ]; then
		sudo cp $tftpd_conf /etc/default/tftpd-hpa.bak
	fi

	if [ ! -d $TFTP_DIR ]; then
		mkdir -p $TFTP_DIR
	fi
	#sudo chmod -R 755 $TFTP_DIR  #不修改权限也可以正常使用

	sudo bash -c "cat > $tftpd_conf" <<EOF
# /etc/default/tftpd-hpa

TFTP_USERNAME="$user"
TFTP_DIRECTORY="$TFTP_DIR"
TFTP_ADDRESS=":69"
TFTP_OPTIONS="--secure -c"
EOF
	# OPTIONS="-l -c -s"
	# -l: --listen 以独立（侦听）模式运行服务器，而不是从inetd运行。在侦听模式中，--timeout选项被忽略，--address选项可用于指定要侦听的特定本地地址或端口 (默认参数)
	# -c: --create 允许创建新文件。默认情况下，tftpd将只允许上传已经存在的文件。除非指定了--permission或--umask选项，否则创建的文件具有允许任何人读取或写入文件的默认权限。
	# -s: --secure 启动时更改根目录。这意味着远程主机不需要作为传输的一部分传递目录，并且可能会增加安全性

	sudo systemctl restart tftpd-hpa.service
	#sudo systemctl enable tftpd-hpa.service
	sudo systemctl status tftpd-hpa.service
}


set -x
#install_old_tftpd
insatll_hpa_tftpd
set +x
