#!/bin/bash

MHD_DEV="/dev/sda1"
MHD_UUID="44DCF081DCF06F14"
MHD_BACKUP_DIR="/media/wqshao/Winddoing/NextCloud/"

SYNC_DIR="/home/wqshao/Nextcloud/"

function check_mhd()
{
	local uuid=$(lsblk -o uuid $MHD_DEV | tail -n1)

	if [ "$uuid" == "$MHD_UUID" ]; then
		return 1
	else
		return 0
	fi
}

if [ ! -b $MHD_DEV ]; then
	echo "Disk device($MHD_DEV) not plugged in."
	exit 3
fi

check_mhd
if [ $? -eq 0 ]; then
	echo "Please check the hard drive."
	exit 1
fi

# waiting to be mounted
sleep 5

if [ ! -d $MHD_BACKUP_DIR ]; then
	echo "Backup directory does not exist!"
	exit 2
fi

if [ ! -d $SYNC_DIR ]; then
	echo "Sync directory does not exist!"
fi

echo "Sync: [$SYNC_DIR], Backup: [$MHD_BACKUP_DIR]"

echo "start sync"
set -x
rsync -avP --delete $SYNC_DIR $MHD_BACKUP_DIR
set +x
echo "complete"
exit 0
