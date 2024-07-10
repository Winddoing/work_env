#!/bin/bash
##########################################################
# Copyright (C) 2024 wqshao All rights reserved.
#  File Name    : build_tools.sh
#  Author       : wqshao
#  Created Time : 2024-07-10 09:18:35
#  Description  :
##########################################################

ARCH=$1

setup_env()
{
	echo "$FUNCNAME: arch=$ARCH"

	if [ x$ARCH == x"arm64" ]; then
		CROSS_COMPILE="aarch64-linux-gnu-"
	fi

	SRC_PATH=${PWD}
	DST_PATH="${PWD}/../$ARCH/bin"
	[ -d $DST_PATH ] || mkdir -p $DST_PATH

	CC=${CROSS_COMPILE}gcc
	STRIP=${CROSS_COMPILE}strip
	OPT="-static"

	echo "SRC_PATH: $SRC_PATH"
	echo "DST_PATH: $DST_PATH"

	echo ""
	echo "CROSS_COMPILE : $CROSS_COMPILE"
	echo "           CC : $CC"
	echo "        STRIP : $STRIP"
	echo "          OPT : $OPT"
	echo ""
}

usage()
{
	echo "Usage:"
	echo "$0 [x86|arm64]"
	exit
}


build_devmem2()
{
	echo "Start: $FUNCNAME"

	local src_dir="$SRC_PATH/devmem"
	set -x
	$CC $OPT $src_dir/devmem2.c -o $DST_PATH/devmem2
	$STRIP $DST_PATH/devmem2
	set +x
}

build_binfile()
{
	echo "Start: $FUNCNAME"

	set -x
	cd $SRC_PATH/binfile
	make
	cd -
	set +x
}

build_lspci()
{
	echo "Start: $FUNCNAME"

	set -x
	wget https://mj.ucw.cz/download/linux/pci/pciutils-3.13.0.tar.gz
	tar xvf pciutils-3.13.0.tar.gz
	cd pciutils-3.13.0
	make CROSS_COMPILE="aarch64-linux-gnu-" HOST="aarch64-linux" OPT="-static" PREFIX=${PWD}/_install  SHARED=no
	cd -
	set +x
}

build_getevent()
{
	echo "Start: $FUNCNAME"

	local src_dir="$SRC_PATH/getevent"
	local input_event_codes_h="/usr/include/linux/input-event-codes.h"

	if [ x$ARCH == x"arm64" ]; then
		input_event_codes_h="/usr/aarch64-linux-gnu/include/linux/input-event-codes.h"
	fi

	set -x
	python $src_dir/generate-input.h-labels.py $input_event_codes_h > $src_dir/input.h-labels.h
	$CC $OPT $src_dir/getevent.c -o $DST_PATH/getevent
	$STRIP $DST_PATH/getevent
	set +x

}

main()
{
	setup_env

	build_devmem2
	[ x$ARCH == x"x86" ] && build_binfile
	#[ x$ARCH == x"arm64" ] && build_lspci
	build_getevent
}

echo $ARCH | grep "x86" > /dev/null || echo $ARCH | grep "arm64" > /dev/null || usage
# main
main
