#!/bin/bash

PWD=`pwd`
user=$USER
home=$HOME
home=$home/tst


function clean_bash()
{
	local bashrc="$home/.bashrc"
	local bashrc_bak="$home/.bashrc_bak"

	if [ -f $bashrc_bak ]; then
		mv $bashrc_bak $bashrc
	fi
}

function main()
{
	clean_bash
}

# start
main
