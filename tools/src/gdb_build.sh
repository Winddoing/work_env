##########################################################
# File Name		: build_gdb.sh
# Author		: winddoing
# Created Time	: 2018年12月13日 星期四 17时06分13秒
# Description	:
##########################################################
#!/bin/bash

PWD=`pwd`

mkdir tmp
cd tmp

if [ ! -f gdb-8.2.tar.gz ]; then
    wget http://101.110.118.57/ftp.gnu.org/gnu/gdb/gdb-8.2.tar.gz
fi

rm gdb-8.2 -rf
tar zxvf gdb-8.2.tar.gz

cd gdb-8.2

./configure --target=arm-linux --prefix=$PWD/_install  --enable-static
make -j2
make install


cd .. #gdb-8.2

cd .. #tmp

cp tmp/gdb-8.2/_install/bin/* ../x86
