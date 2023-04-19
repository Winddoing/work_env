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

TFTP_DIR="$home/share/tftprootfs"

sudo apt-get install tftpd tftp xinetd

if [ ! -d $TFTP_DIR ]; then
    sudo mkdir -p $TFTP_DIR
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



