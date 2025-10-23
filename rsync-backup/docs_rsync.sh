#!/bin/bash
##########################################################
# Copyright (C) 2025 wqshao All rights reserved.
#  File Name    : docs_rsync.sh
#  Author       : wqshao
#  Created Time : 2025-10-21 09:09:10
#  Description  :
##########################################################

DST_DIR="/media/wqshao/WangQuan"
SRC_DIR="$HOME/Documents"

echo "DST_DIR: $DST_DIR"
echo "SRC_DIR: $SRC_DIR"

if [ ! -d $DST_DIR ]; then
	echo "Not found: $DST_DIR"
	exit -1
fi

set -x
rsync -a --delete --progress $SRC_DIR $DST_DIR 
#sync
set +x
echo "complete"
exit 0
