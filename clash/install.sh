#!/bin/bash
##########################################################
# Copyright (C) 2023 wqshao All rights reserved.
#  File Name    : install.sh
#  Author       : wqshao
#  Created Time : 2023-03-03 14:01:51
#  Description  :
##########################################################

if [ $# -ne 1 ]; then
	echo "$0 <订阅连接>"
	exit 0
fi

CLASH_FILE_NAME="clash-linux-amd64-v1.18.0"
CLASH_PACKAGE_NAME="$CLASH_FILE_NAME.gz"
CLASH_PACKAGE_URL="https://github.com/Dreamacro/clash/releases/download/v1.13.0/$CLASH_PACKAGE_NAME"

CLASH_INSTALL_PATH="/opt/clash"
CLASH_BIN="$CLASH_INSTALL_PATH/clash"
CLASH_CONFIG_YAML="$CLASH_INSTALL_PATH/config.yaml"
CLASH_COUNTRY_MMDB="$CLASH_INSTALL_PATH/Country.mmdb"
CLASH_UPDATE_SUBSCRIBE_SH="$CLASH_INSTALL_PATH/auto_update.sh"


#PROXY_SUBSCRIBE_URL="https://xxxxxxxxxxxxxxxxxx06d2739906177ad22&flag=clash"
PROXY_SUBSCRIBE_URL="$1&flag=clash"
CLASH_COUNTRY_MMDB_URL="https://www.sub-speeder.com/client-download/Country.mmdb"

echo "PROXY_SUBSCRIBE_URL: $PROXY_SUBSCRIBE_URL"

download_install_clash()
{
	echo "Download and Install clash."

	[ -d $CLASH_INSTALL_PATH ] || mkdir -p $CLASH_INSTALL_PATH

	if [ ! -f $CLASH_BIN ]; then
		cd /tmp
		set -x
		wget $CLASH_PACKAGE_URL

		gzip -d $CLASH_PACKAGE_NAME

		chmod +x $CLASH_FILE_NAME

		set +X
		cd -

		cp /tmp/$CLASH_FILE_NAME $CLASH_BIN
	fi
}

setting_clash()
{
	echo "Setting clash."

	set -x
	[ -f $CLASH_CONFIG_YAML ] || wget -O $CLASH_CONFIG_YAML "$PROXY_SUBSCRIBE_URL"
	[ -f $CLASH_COUNTRY_MMDB ] || wget -O $CLASH_COUNTRY_MMDB "$CLASH_COUNTRY_MMDB_URL"
	set +x
}

config_clash_service()
{
	echo "Config clash service."

	sudo cat > $CLASH_UPDATE_SUBSCRIBE_SH << EOF
#!/bin/bash

set -x

echo "stop clash service"
sudo systemctl stop clash.service

# 加载最新订阅配置
echo "download latest config"
#sudo wget -O $CLASH_INSTALL_PATH/config.yaml.new "$PROXY_SUBSCRIBE_URL"
sudo curl -o $CLASH_INSTALL_PATH/config.yaml.new "$PROXY_SUBSCRIBE_URL"
if [ \$? -ne 0 ]; then
	echo "Download <$PROXY_SUBSCRIBE_URL> faild."
	exit
fi
# 备份原订阅配置
if [ ! -d "$CLASH_INSTALL_PATH/backup" ]; then
	echo "create backup directory"
	sudo mkdir $CLASH_INSTALL_PATH/backup
fi
echo "move config.yaml to $CLASH_INSTALL_PATH/backup"
sudo mv $CLASH_CONFIG_YAML $CLASH_INSTALL_PATH/backup/config_\`date '+%Y%m%d%H%M%S'\`

# 替换配置
echo "replace config.yaml"
sudo mv $CLASH_INSTALL_PATH/config.yaml.new $CLASH_CONFIG_YAML

# 重启clash
echo "start clash service"
sudo systemctl restart clash.service

sudo systemctl status clash.service --no-pager
EOF
	chmod +x $CLASH_UPDATE_SUBSCRIBE_SH

	sudo cat > /usr/lib/systemd/system/clash.service << EOF
[Unit]
Description=clash linux
After=network-online.target

[Service]
Type=simple
ExecStart=$CLASH_BIN -d $CLASH_INSTALL_PATH
ExecStop=pkill -9 clash
Restart=always

[Install]
WantedBy=multi-user.target
EOF

	# 重新加载配置文件
	sudo systemctl daemon-reload

	$CLASH_UPDATE_SUBSCRIBE_SH

	sudo systemctl restart clash
	sudo systemctl status clash

	# 设置开机自启
	#sudo systemctl enable clash

	echo "Manage URL: http://clash.razord.top"
}

dump_crontab_cfg()
{
	echo "Dump crontab cfg."

	echo "******************************************"
	echo "  sudo crontab -e"
	echo ""
	echo "# 每星期更新一次"
	echo "30 0 * * 0 sh $CLASH_UPDATE_SUBSCRIBE_SH"
	echo ""
	echo "  sudo systemctl restart cron.service"
	echo "******************************************"
}

main()
{
	download_install_clash
	setting_clash
	config_clash_service

	dump_crontab_cfg
}

sudo -v &>/dev/null
if [ $? != 0 ]; then
	echo "$(whoami) is not sudo user"
	exit -1
fi

main

