#!/bin/bash
##########################################################
# Copyright (C) 2025  All rights reserved.
#  File Name    : goldendict-ocr.sh
#  Author       : wqshao
#  Created Time : 2025-06-23 17:27:09
#  Description  :
##########################################################

SCREENSHOT_PATH="/tmp/fanyi-wq-ocrdata.png"
OCRDATA_PATH="/tmp/fanyi-wq-ocrdata"
OCRDATA_TXT="${OCRDATA_PATH}.txt"


if ! command -v flameshot &> /dev/null
then
    echo "<flameshot> could not be found, sudo apt install flameshot"
    exit
fi
if ! command -v tesseract &> /dev/null
then
    echo "<tesseract> could not be found, sudo apt install tesseract-ocr"
    exit
fi
if ! command -v goldendict &> /dev/null
then
    echo "<goldendict> could not be found, sudo apt install goldendict"
    exit
fi

echo "$SCREENSHOT_PATH, $OCRDATA_PATH, $OCRDATA_TXT"

#flameshot gui -s -p ${SCREENSHOT_PATH}
scrot -s -F ${SCREENSHOT_PATH}
tesseract ${SCREENSHOT_PATH} ${OCRDATA_PATH} -l eng

TXT=$(cat ${OCRDATA_TXT} | tr "\n" " ")
echo "[$TXT]"

if [ -n "$TXT" ]; then
	goldendict "${TXT}"
fi

if [ -e $SCREENSHOT_PATH ]; then
	rm -f $SCREENSHOT_PATH
fi
if [ -e $OCRDATA_TXT ]; then
	rm -f $OCRDATA_TXT
fi
