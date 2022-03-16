#!/bin/bash
##########################################################
# File Name		: update_hosts.sh
# Author		: winddoing
# Created Time	: 2022年03月09日 星期三 11时06分29秒
# Description	:
##########################################################

HOSTS="/etc/hosts"
BAK_HOSTS="/etc/hosts.bak"
NEW_HOSTS="/tmp/hosts.new"
GITHUB_HOSTS="/tmp/host.github"
FLAG_STR="# Added by winddoing"

# 1.添加标志，方便删除
grep -rn "$FLAG_STR" $HOSTS > /dev/null
if [ $? -ne 0 ]; then
	echo "Backup hosts"
	sudo cp $HOSTS $BAK_HOSTS -apv

	echo "Add flag: [$FLAG_STR]"
	sudo echo "" >> $HOSTS
	sudo echo "$FLAG_STR" >> $HOSTS
	sudo echo "" >> $HOSTS
fi

# 2.删除旧的配置
echo "Delte old config"
start_line=$(grep -rn "$FLAG_STR" $HOSTS |awk -F ':' '{print $1}')
start_line=$((start_line + 2))
end_line=$(sed -n '$=' $HOSTS)

sudo sed -i "${start_line},${end_line}d" $HOSTS

# 3.下载最新host文件为github
echo "Download the latest hosts"
wget -qO $GITHUB_HOSTS https://gitee.com/ineo6/hosts/raw/master/hosts

# 4.文件合并
echo "Merge hosts"
cat $HOSTS $GITHUB_HOSTS > $NEW_HOSTS

# 5.更新hosts文件并刷新
echo "Update $HOSTS"
sudo cp $NEW_HOSTS $HOSTS -arpv
sudo systemd-resolve --flush-caches

cat $HOSTS
