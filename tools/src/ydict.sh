##########################################################
# File Name		: ydict.sh
# Author		: winddoing
# Created Time	: 2019年02月02日 星期六 11时50分05秒
# Description	:
##########################################################
#!/bin/bash

# https://github.com/TimothyYe/ydict


sudo apt-get install mpg123

cd ./tmp

wget https://github.com/TimothyYe/ydict/releases/download/V1.2.1/ydict-linux64-1.2.1.tar.gz

tar zxvf ydict-linux64-1.2.1.tar.gz

cd ..

cp ./tmp/ydict ../x86/


