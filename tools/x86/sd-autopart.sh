#!/bin/bash
##########################################################
# File Name		: autopart.sh
# Author		: winddoing
# Created Time	: 2021年10月12日 星期二 14时13分12秒
# Description	: 将SD卡设置为GPT分区格式,并分三个区为boot,rootfs,data
#
# For example (default configuration):
# Device       Start      End  Sectors  Size Type
# /dev/sda1     2048    40959    38912   19M Linux filesystem
# /dev/sda2    40960  1064959  1024000  500M Linux filesystem
# /dev/sda3  1064960  5259263  4194304    2G Linux filesystem
# /dev/sda4  5259264 62332927 57073664 27.2G Linux filesystem
##########################################################

sd_dev=$1
part_type=gpt
unit="MiB"
free_space=1 #2M size for spl+uboot

part_table=(
	#part_name  size  format
	'boot        19     0'
	'rootfs      500    0'
	'userdata    2048   1'
	'other       100%   1'
)
# 100%：表示剩余所有空间

if [ $# -lt 1 ]; then
	echo "Usage: $0 <device>"
	echo "example: $0 /dev/sdb"
	exit
fi

if [ x$part_type != x"gpt" ] && [ x$part_type != x"msdos" ]; then
	echo "part_type=$part_type"
	echo "Currently partition type only supports [msdos] and [gpt]"
	echo ""
	exit
fi

which parted > /dev/null
if [ $? -ne 0 ]; then
	sudo apt install parted
fi
which fdisk > /dev/null
if [ $? -ne 0 ]; then
	sudo apt install fdisk
fi

echo I | sudo parted ${sd_dev} print | grep "MassStorageClass" > /dev/null
if [ $? -ne 0 ]; then
	echo "the current device($sd_dev) is not an SD card"
	exit
fi

set -x

echo "Delete old partition table ..."
partition_num=$(sudo fdisk -l $sd_dev | grep "$sd_dev[0-9]" | wc -l)
echo "Dev: ${sd_dev}, old partition sum: $partition_num"
for partition in `seq 1 $partition_num`
do
	echo "  delete partition $sd_dev num $partition"
	sudo umount ${sd_dev}${partition}
	sudo parted $sd_dev rm $partition
done
sudo parted ${sd_dev} quit
sync

echo "Create a GPT disklabel (partition table)"
yes | sudo parted ${sd_dev} mklabel ${part_type}
sudo parted ${sd_dev} quit
sync

set +x

pstart=0
pend=0
index=1
echo "Create partition !"
for part in "${part_table[@]}"
do
	part_line=($part)
	part_name=${part_line[0]}
	part_size=${part_line[1]}
	part_format=${part_line[2]}
	#echo "part_line: ${part_line[@]}"
	#echo "name: $part_name, size: $part_size, format: $part_format"
	echo "===> Create partition [$part_name]"
	if [ $pstart = 0 ]; then
		pstart=$((pstart + free_space))
	else
		pstart=$pend
	fi
	if [ $part_size = 100% ]; then
		pend=$part_size
	else
		pend=$((pstart + part_size))
	fi
	set -x
	sudo parted ${sd_dev} mkpart ${part_name} ${pstart}${unit} ${pend}${unit}
	sudo parted ${sd_dev} quit
	set +x
	if [ $part_format = 1 ]; then
		echo "Format the data partition(${sd_dev}${index}) as ext4"
		yes | sudo mkfs.ext4 ${sd_dev}${index}
	fi
	index=$((index + 1))
	sync
done

sync
sudo parted ${sd_dev} print
sudo fdisk -l ${sd_dev}
