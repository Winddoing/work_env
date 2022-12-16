#!/bin/bash

#old_plug_url="https://git::@hub.fastgit.xyz"
#new_plug_url="https://github.com"

old_plug_url="https://github.com"
new_plug_url="https://github.91chi.fun/https://github.com"

for plug in `ls ./plugged`
do
	echo "Plug dir: $plug"
	cd ./plugged
	cd $plug

	old_url=$(git remote -v | grep fetch | awk '{print $2}')
	echo "old url: $old_url"
	new_url=${old_url/$old_plug_url/$new_plug_url}
	echo "new url: $new_url"
	git remote set-url origin $new_url
	if [ $? -eq 0 ]; then
		echo "OK"
	else
		echo "Err"
	fi
	cd ..
	cd ..
done
