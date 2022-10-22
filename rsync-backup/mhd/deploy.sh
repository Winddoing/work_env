#!/bin/bash

set -x

# install
function install_mhd_sync()
{
	sudo cp ./mhd_monitor.path /etc/systemd/system/ -arpv
	sudo cp ./mhd_backup.service /etc/systemd/system/ -arpv

	sudo systemctl enable --now mhd_monitor.path
	sudo systemctl enable --now mhd_backup.service
}

# delete
function delete_mhd_sync()
{
	sudo systemctl disable --now mhd_monitor.path
	sudo systemctl disable --now mhd_backup.service

	sudo rm /etc/systemd/system/mhd_backup.service
	sudo rm /etc/systemd/system/mhd_monitor.path
}



if [ "$1" == "install" ]; then
	install_mhd_sync
elif [ "$1" == "delete" ]; then
	delete_mhd_sync
else
	echo "Usage: $0 [install/delete]"
fi


