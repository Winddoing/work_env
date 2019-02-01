##########################################################
# File Name		: install.sh
# Author		: winddoing
# Created Time	: 2019年02月01日 星期五 10时35分29秒
# Description	:
##########################################################
#!/bin/bash

PWD=`pwd`
user=$USER
home=$HOME

NFS_DIR="$home/nfs"

# ubuntu 18.04
sudo apt-get install nfs-kernel-server

sudo cp /etc/exports /etc/exports-bak

cat exports > exports-tmp

echo "$NFS_DIR *(rw,sync,no_root_squash)" >> exports-tmp

if [ ! -d $NFS_DIR ]; then
    sudo mkdir $NFS_DIR
fi

sudo cp exports-tmp /etc/exports

rm exports-tmp

sudo systemctl restart nfs-server

sudo /etc/init.d/nfs-kernel-server restart






