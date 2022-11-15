#!/bin/bash
##########################################################
# Copyright (C) 2022 wqshao All rights reserved.
#  File Name    : zeal_download_url.sh
#  Author       : wqshao
#  Created Time : 2022-11-11 14:38:10
#  Description  :
##########################################################

# 文档名字查找：https://api.zealdocs.org/v1/docsets
DOCS_LIST="C C++ CMake OpenGL_2 OpenGL_3 OpenGL_4 Qt_6 Rust Python_3 Markdown"
DOCS_DIR="$HOME/Documents/zeal"

download()
{
	#for city_name in frankfurt london newyork sanfrancisco singapore sydney tokyo
	for city_name in frankfurt
	do
		for doc_name in $DOCS_LIST
		do
			url="http://${city_name}.kapeli.com/feeds/${doc_name}.tgz"
			echo "$url"
			#wget $url
			/opt/freedownloadmanager/fdm $url &
		done
	done
}

unpack()
{
	[ ! -d $DOCS_DIR ] && mkdir $DOCS_DIR

	for doc_name in $DOCS_LIST
	do
		doc_pack="$HOME/Downloads/${doc_name}.tgz"
		[ ! -f $doc_pack ] && echo "$doc_pack does not exist"; exit 1

		tar_cmd="tar zxf $doc_pack -C $DOCS_DIR"
		echo $tar_cmd; $tar_cmd
	done
	
}


if [ x"$1" = x"download" ]; then
	download
elif [ x"$1" = x"unpack" ]; then
	unpack
else
	echo "Usage: $0 [download | unpack]"
fi
