#!/bin/bash
##########################################################
# Copyright (C) 2023 wqshao All rights reserved.
#  File Name    : append_new_fonts.sh
#  Author       : wqshao
#  Created Time : 2023-12-15 16:48:37
#  Description  :
##########################################################
TOP=${PWD}

BASE_FONTS_PATH="/usr/share/fonts"

FONTS_BOX_REPO="$TOP/win-fonts-box"

[ ${UID} -ne 0 ] && echo "Please run with sudo" && exit -1

function show_installed_fonts()
{
	echo "--> $FUNCNAME"

	echo "WPS font:"
	fc-list | grep "wps-office"

	echo "YaHei font:"
	fc-list | grep "YaHei"
}

function update_fonts_cache()
{
	echo "--> $FUNCNAME"

	# 更新字体缓存
	sudo fc-cache
}

function create_font_index()
{
	local font_path=$1

	echo "--> $FUNCNAME, font_path=$font_path"

	cd $font_path
	# 生成字体的索引信息
	sudo mkfontscale
	sudo mkfontdir
	cd -
}

function append_font()
{
	echo "--> $FUNCNAME"
	for font_dir in `ls $FONTS_BOX_REPO`
	do
		echo "font_dir=$font_dir"
		font_path="$BASE_FONTS_PATH/$font_dir"
		set -x
		[ -d $font_path ] || sudo mkdir -p $font_path
		sudo cp $FONTS_BOX_REPO/$font_dir/* $font_path
		set +x

		create_font_index $font_path
	done
}

# main
append_font

update_fonts_cache
show_installed_fonts
