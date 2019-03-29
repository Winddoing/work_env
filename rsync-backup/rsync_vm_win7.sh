##########################################################
# File Name		: rsync_vm_win7.sh
# Author		: winddoing
# Created Time	: 2019年03月28日 星期四 10时22分25秒
# Description	:
##########################################################
#!/bin/bash


rsync -a --delete /home/wqshao/VirtualBoxVMs/New\ group/window7/ shaowangquan@172.16.200.101:/home/shaowangquan/local-backup/window7 --progress > /dev/null 2>&1

# --delete 删除那些DST中SRC没有的文件
# -a, --archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD。

