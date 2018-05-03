##########################################################
# File Name		: a.sh
# Author		: wqshao
# Created Time	: 2017年04月01日 星期六 14时26分47秒
# Description	:
##########################################################
#!/bin/bash

PWD=`pwd`
WORD_KEY="wqshao"

function usage()
{
	echo "$0"
	echo "Usage:"
	echo "	-d : file dirs"
	echo "	-k : find keyword"
	echo "	-h : help"

	echo "example:"
	echo "	$0 -k "wqshao" -d drivers/mmc"
	exit 0
}

while getopts "d:hk:" opt
do  
	case $opt in  
		d)  
			DIR_APPEND=$OPTARG
			;;  
		k)
			WORD_KEY=$OPTARG
			;;
		h)
			usage
			;;
		?)  
			exit -1;
			;;  
	esac  
done  

DIR="$PWD/$DIR_APPEND"
#echo "dir: $DIR"
#echo "word: $WORD_KEY"
# args:
#   $1 : key word
#   $2 : file path
#	$3 : temp file path
function del_key_line()
{
	grep -v "$1" $2 > $3
	mv $3 $2

	return 0
}

function del_file_keyword_line()
{
	local file_list

	file_list=`find $1 -name "*.[ch]"`
	for file in $file_list
	do
		file_tmp="${file}-tmp"
		#echo "--file: $file"
		#echo "--tmp-file: $file_tmp"
		del_key_line $2 $file $file_tmp
	done

	exit 0
}


# lookup keyword and delete line
echo "lookup $DIR ..."
echo "Del keyword {$WORD_KEY}"
del_file_keyword_line $DIR $WORD_KEY

