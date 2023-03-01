#!/bin/bash
##########################################################
# Copyright (C) 2023 wqshao All rights reserved.
#  File Name    : vim_deploy.sh
#  Author       : wqshao
#  Created Time : 2023-03-01 15:37:31
#  Description  :
##########################################################

echo "Download vim config."

vim_dir=$(mktemp --tmpdir -d vim.XXX)

cd $vim_dir
git init
git config core.sparseCheckout true
echo "vim" >>  .git/info/sparse-checkout
git remote add origin https://gitee.com/winddoing/work_env.git
git pull origin master --depth=1
vim_last_modify=$(git log  | grep Date)
cd -

echo "Install vim config $vim_last_modify"
mv $vim_dir/vim ~/.vim
mv ~/.vim/vimrc ~/.vimrc

rm $vim_dir
