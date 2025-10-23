#!/bin/bash
##########################################################
# Copyright (C) 2024 wqshao All rights reserved.
#  File Name    : pcie_cfg_gen_tlscan.sh
#  Author       : wqshao
#  Created Time : 2024-07-09 14:22:44
#  Description  :
# 	TeleScan PE PCIe配置空间解析工具
# 官网：[Teledyne LeCroy - PCI Express Analysis Software](https://www.teledynelecroy.com/protocolanalyzer/pci-express/telescan-pe-software/resources/analysis-software)
# CSDN：[TeleScanPEPCIE驱动调试工具\_pcie调试工具资源-CSDN文库](https://download.csdn.net/download/adm7n/85637703)   已备份阿里云盘
##########################################################

#pcie_cfg_file="/sys/bus/pci/devices/0000\:00\:02.0/config"

# sudo cat /sys/bus/pci/devices/0000\:00\:02.0/config > amd_cfg_space.bin

pcie_cfg_file=$1

if [ $# -ne 1 ]; then
	echo "Usage:"
	echo "	$0 <pcie_cfg_space_bin>"
	echo " pcie_cfg_space_bin:"
	echo "  cat /sys/bus/pci/devices/0000\:00\:02.0/config > cfg_space.bin"
	exit 1
fi

if [ ! -f $pcie_cfg_file ]; then
	echo "[$pcie_cfg_file] file does not exist."
	exit
fi

tlscan_file="${pcie_cfg_file}.tlscan"

echo "PCIe dev: $pcie_cfg_file"
echo "TLSCAN file: $tlscan_file"

cat > $tlscan_file << EOF
<devices>
 <device bus="0xff" device="0xff" type="pciexpress" function="0xff">
  <config_space>
   <bytes>
   `hexdump -e '32/1 "%02x " "\n"' -v ${pcie_cfg_file}`
   </bytes>
  </config_space>
 </device>
</devices>
EOF

echo "Gen success!"
