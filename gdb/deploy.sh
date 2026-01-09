#!/bin/bash
##########################################################
# Copyright (C) 2026 wqshao All rights reserved.
#  File Name    : deploy.sh
#  Author       : wqshao
#  Created Time : 2026-01-09 17:02:35
#  Description  :
##########################################################
set -ex

DATA_TIME=`date +%Y%m%d%H%M`

GDBINIT_BAK_OLD="$PWD/gdbinit_$DATA_TIME.old"
if [ -e ~/.gdbinit ]; then
	cp ~/.gdbinit $GDBINIT_BAK_OLD
	rm ~/.gdbinit
fi

GDB_DASHBOARD="$PWD/gdbinit-dashboard"

if [ ! -f $GDB_DASHBOARD ]; then
	wget -P https://git.io/.gdbinit $GDB_DASHBOARD
fi

ln -s $GDB_DASHBOARD ~/.gdbinit
