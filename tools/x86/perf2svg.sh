#!/bin/bash
##########################################################
# File Name		: perf2svg.sh
# Author		: winddoing
# Created Time	: 2021年02月24日 星期三 14时15分29秒
# Description	:
##########################################################

#set -x

if [ $# -eq 0 ]; then
    echo "usage: $0 <pid>"
    exit 1
fi

sudo -v

pid=$1

echo "Perf record ..."
sudo perf record -F 99 -g -p $pid  -- sleep 60

echo "Perf script ..."
sudo perf script -i perf.data  > perf.unfold

if [ ! -d "FlameGraph" ]; then
    git clone --depth=1 https://gitee.com/mirrors/FlameGraph.git > /dev/null
fi

echo "Convert to svg ..."
./FlameGraph/stackcollapse-perf.pl perf.unfold > perf.folded
./FlameGraph/flamegraph.pl perf.folded > perf.svg

echo -e "\tfile://$PWD/perf.svg"
