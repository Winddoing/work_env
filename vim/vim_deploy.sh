#!/bin/bash
##########################################################
# Copyright (C) 2023 wqshao All rights reserved.
#  File Name    : vim_deploy.sh
#  Author       : wqshao
#  Created Time : 2023-03-01 15:37:31
#  Description  :
##########################################################

echo "Download vim config."

vim_dir=$(mktemp --tmpdir -d vim.XXXX)

cd $vim_dir
git init
git config core.sparseCheckout true
echo "vim" >>  .git/info/sparse-checkout
git remote add origin https://gitee.com/winddoing/work_env.git
git pull origin master --depth=1
vim_last_modify=$(git log  | grep Date)
cd -

echo "Install vim config $vim_last_modify"
[ -d ~/.vim ] && rm -rf ~/.vim
mv $vim_dir/vim ~/.vim
[ -f ~/.vimrc ] && rm -rf ~/.vimrc
mv ~/.vim/vimrc ~/.vimrc

rm -rf $vim_dir

github_url="let g:plug_url_format='https://ghproxy.com/https://github.com/%s.git'"

sed -i "/plug#begin/i$github_url" ~/.vimrc

echo "\"Config time: $vim_last_modify" >> ~/.vimrc
echo "\"Install time: $(date)" >> ~/.vimrc

echo "PlugInstall..."
vim -c PlugInstall
