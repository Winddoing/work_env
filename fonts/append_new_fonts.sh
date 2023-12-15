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

WPS_FONT_PATH="$BASE_FONTS_PATH/wps-office"
YAHEI_FONT_PATH="$BASE_FONTS_PATH/YaHeiConsolas"

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

function append_wps_font()
{
	echo "--> $FUNCNAME"

	set -x
	[ -d $YAHEI_FONT_PATH ] || sudo mkdir -p $WPS_FONT_PATH
	sudo unzip -o $FONTS_BOX_REPO/wps_symbol_fonts.zip -d $WPS_FONT_PATH
	set +x

	create_font_index $WPS_FONT_PATH
}

function append_yahei_font()
{
	echo "--> $FUNCNAME"

	set -x
	[ -d $YAHEI_FONT_PATH ] || sudo mkdir -p $YAHEI_FONT_PATH
	sudo cp $FONTS_BOX_REPO/YaHeiConsolas.ttf $YAHEI_FONT_PATH
	set +x

	create_font_index $YAHEI_FONT_PATH
}

# main
append_wps_font
append_yahei_font


update_fonts_cache
show_installed_fonts
