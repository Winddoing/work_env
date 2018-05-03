##########################################################
# File Name		: make_ramdisk.sh
# Author		: wqshao
# Created Time	: 2017年06月08日 星期四 16时37分48秒
# Description	:
##########################################################
#!/bin/bash

find . | cpio -o -Hnewc |gzip -9 > ../image.cpio.gz
