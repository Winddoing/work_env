##########################################################
# File Name		: build_gdb.sh
# Author		: winddoing
# Created Time	: 2018年12月13日 星期四 17时06分13秒
# Description	:
##########################################################
#!/bin/bash

PWD=`pwd`
CROSS_GCC_CC=aarch64-linux-gcc
DEFAULT_TARGET_ARRAY=(arm-linux aarch64-linux)
DEFAULT_TARGET_CNT=${#DEFAULT_TARGET_ARRAY[@]}

for target in ${DEFAULT_TARGET_ARRAY[@]}
do
    if [ X$1 != X$target ]; then
        DEFAULT_TARGET_CNT=$(($DEFAULT_TARGET_CNT-1))
    fi
    echo ${target} ${DEFAULT_TARGET_CNT}
done
TARGET=$1

if [ $# -eq 0 ] || [ $DEFAULT_TARGET_CNT -eq 0 ]; then
    echo "  Usage: $0 [arm-linux|aarch64-linux]"
    echo ""
    echo "      example" $0 arm-linux
    exit 0;
fi

if [ X$TARGET == X$DEFAULT_TARGET[0] ]; then
    INSTALL_DIR="_${TARGET}_install"
else
    INSTALL_DIR="_${TARGET}_install"
fi

if [ ! -z $CROSS_GCC_CC ]; then
    INSTALL_DIR="_cross_${INSTALL_DIR}"
fi

echo "==> $0 $1 $# $INSTALL_DIR $DEFAULT_TARGET_CNT"

mkdir tmp
cd tmp

if [ ! -f gdb-8.2.tar.gz ]; then
    wget http://101.110.118.57/ftp.gnu.org/gnu/gdb/gdb-8.2.tar.gz
fi

INSTALL_PATH="$PWD/${INSTALL_DIR}"
rm gdb-8.2 -rf
tar zxvf gdb-8.2.tar.gz

cd gdb-8.2

if [ -z $CROSS_GCC_CC]; then
    ./configure --target=$TARGET --prefix=${INSTALL_PATH}  --enable-static
else
    ./configure CC=${CROSS_GCC_CC} --target=${TARGET} --host=${TARGET} --prefix=${INSTALL_PATH}  --enable-static
fi

make -j2
make install


cd .. #gdb-8.2

cd .. #tmp

echo "INSTALL_PATH: ${INSTALL_PATH}"

if [ -z ${CROSS_GCC_CC} ]; then
    cp ${INSTALL_PATH}/bin/* ../x86 -v
fi
