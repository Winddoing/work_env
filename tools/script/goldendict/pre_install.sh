#!/bin/bash
##########################################################
# Copyright (C) 2024  All rights reserved.
#  File Name    : pre_install.sh
#  Author       : wqshao
#  Created Time : 2024-08-09 22:36:02
#  Description  :
#  图标下载地址：https://www.iconfont.cn   图标大小32pixels
##########################################################

echo ""
echo "依赖软件：sudo apt install python3-lxml"
echo ""

echo -e "html\t有道字典\tpython $PWD/youdao_dict.py %GDWORD%\t$PWD/youdao_dict.png"
echo -e "html\t有道翻译\tpython $PWD/youdao_fanyi.py %GDWORD%\t$PWD/youdao_fanyi.png"
echo -e "html\t百度翻译\tpython $PWD/baidu_fanyi.py %GDWORD%\t$PWD/baidu_fanyi.png"
echo -e "html\t必应翻译\tpython $PWD/bing_fanyi.py %GDWORD%\t$PWD/bing_fanyi.png"

echo ""
echo "注：百度翻译需要key,配置路径$HOME/.goldendict/.api_key.yaml"

#配置文件格式：
#baidu:
#   id: 2024123
#   secret: abc
