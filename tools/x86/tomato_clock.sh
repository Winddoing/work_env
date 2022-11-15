#!/bin/bash

# 到达设置时间后，桌面显示指定图片
# feh 显示壁纸

t=$1
t=`echo ${t:-30}`

echo "time:$t min"

echo 'env DISPLAY=:1 feh -F ~/Pictures/Wallpapers/windows-xp-3840x2160-bliss-microsoft-4k-23534.jpg' | at now+$t minutes
