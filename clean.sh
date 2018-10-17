#!/bin/bash

PWD=`pwd`
user=$USER
home=$HOME


function clean_dotfile()
{
	rm $home/.vimrc
	rm $home/.gitconfig
	rm $home/.tmux.conf
}

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
	clean_dotfile
}

# start
main
