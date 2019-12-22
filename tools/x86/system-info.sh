#!/bin/bash
##########################################################
# File Name		: system-info.sh
# Author		: winddoing
# Created Time	: 2019年12月21日 星期六 21时44分09秒
# Description	:
##########################################################

#!/bin/bash 

sudo -l

echo -e "-------------------------------System Information----------------------------" 
echo -e "Hostname:\t\t"`hostname` 
echo -e "uptime:\t\t\t"`uptime | awk '{print $3,$4}' | sed 's/,//'` 
echo -e "Manufacturer:\t\t"`cat /sys/class/dmi/id/chassis_vendor` 
echo -e "Product Name:\t\t"`cat /sys/class/dmi/id/product_name` 
echo -e "Version:\t\t"`cat /sys/class/dmi/id/product_version` 
echo -e "Serial Number:\t\t"`sudo cat /sys/class/dmi/id/product_serial` 
echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi`
echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` 
echo -e "Kernel:\t\t\t"`uname -r` 
echo -e "Architecture:\t\t"`arch` 
echo -e "Processor Name:\t\t"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'` 
echo -e "Active User:\t\t"`w | cut -d ' ' -f1 | grep -v USER | xargs -n1` 
echo -e "System Main IP:\t\t"`hostname -i` 
echo " "

echo -e "-------------------------------CPU/Memory Usage------------------------------" 
echo -e "Memory Usage:\t"`free | awk '/Mem/{printf "%.2f%%", $3/$2*100}'` 
echo -e "Swap Usage:\t"`free | awk '/Swap/{printf "%.2f%%", $3/$2*100}'` 
echo -e "CPU Usage:\t"`cat /proc/stat | awk '/cpu/{printf "%.2f%%\n", ($2+$4)*100/($2+$4+$5)}' | awk '{print $0}' | head -1` 
echo "" 

echo -e "-------------------------------Disk Information------------------------------" 
for dev in `ls /dev/sd?`
do
    echo -e "$dev:"
    sudo hdparm -i $dev | grep "Model"
done
echo "" 

echo -e "-------------------------------Disk Usage >80%-------------------------------" 
df -Ph | sed s/%//g | awk '{ if($5 > 80) print $0;}'
echo "" 

echo -e "-------------------------------Package Updates-------------------------------" 
if (( $(cat /etc/*-release | grep -w "Oracle|Red Hat|CentOS|Fedora" | wc -l) > 0 )) 
then 
    sudo yum updateinfo summary | grep 'Security|Bugfix|Enhancement' 
else 
    sudo cat /var/lib/update-notifier/updates-available 
fi
echo -e "-----------------------------------------------------------------------------" 
