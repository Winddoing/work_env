##########################################################
# File Name		: build_gdb.sh
# Author		: winddoing
# Created Time	: 2018年12月13日 星期四 17时06分13秒
# Description	:
##########################################################
#!/bin/bash

PWD=`pwd`
GDB_VERSION="gdb-8.3"
#CROSS_GCC_CC=aarch64-linux-gcc

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
    echo "  Usage: $0 [arm-linux|aarch64-linux] #Select platform"
    echo ""
    echo "      example" $0 aarch64-linux
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

echo "==> $0 $1 $# $INSTALL_DIR $DEFAULT_TARGET_CNT gdb version: ${GDB_VERSION}.tar.gz"

if [ ! -d tmp ];then
	mkdir tmp
fi
cd tmp

#Downlond link:
#	ftp://ftp.gnu.org/gnu/gdb/
#	http://www.mirrorservice.org/sites/ftp.gnu.org/gnu/gdb/
if [ ! -f ${GDB_VERSION}.tar.gz ]; then
    #wget http://101.110.118.57/ftp.gnu.org/gnu/gdb/${GDB_VERSION}.tar.gz
	wget http://www.mirrorservice.org/sites/ftp.gnu.org/gnu/gdb/${GDB_VERSION}.tar.gz
fi

INSTALL_PATH="$PWD/${INSTALL_DIR}"

echo "Deleting file ${GDB_VERSION} ..."
rm ${GDB_VERSION} -rf
tar zxvf ${GDB_VERSION}.tar.gz

cd ${GDB_VERSION}

if [ -z $CROSS_GCC_CC ]; then
    ./configure --target=$TARGET --prefix=${INSTALL_PATH}  --enable-static
else
    echo "./configure CC=${CROSS_GCC_CC} --target=${TARGET} --host=${TARGET} --prefix=${INSTALL_PATH}  --enable-static"
    ./configure CC=${CROSS_GCC_CC} --target=${TARGET} --host=${TARGET} --prefix=${INSTALL_PATH}  --enable-static
fi

make -j2
make install


cd .. #${GDB_VERSION}

cd .. #tmp

echo "INSTALL_PATH: ${INSTALL_PATH}"

if [ -z ${CROSS_GCC_CC} ]; then
    cp ${INSTALL_PATH}/bin/* ../x86 -v
fi
