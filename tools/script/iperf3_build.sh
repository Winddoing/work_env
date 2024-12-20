#!/bin/bash
##########################################################
# Copyright (C) 2024 wqshao All rights reserved.
#  File Name    : iperf3_build.sh
#  Author       : wqshao
#  Created Time : 2024-06-27 09:38:22
#  Description  :
##########################################################

#!/usr/bin/env bash

HOME="$(pwd)"
with_openssl="${1:-no}"
cygwin_path="${2:-${HOME}}/cygwin"

printf '\n%b\n' " \e[93m\U25cf\e[0m With openssl = ${with_openssl}"
printf '%b\n' " \e[93m\U25cf\e[0m Build path = ${HOME}"
printf '%b\n' " \e[93m\U25cf\e[0m Cygwin path = ${cygwin_path}"

if [[ "${with_openssl}" == 'yes' ]]; then
	printf '\n%b\n' " \e[94m\U25cf\e[0m Downloading zlib"
	curl -sL https://github.com/userdocs/qbt-workflow-files/releases/latest/download/zlib.tar.xz -o "${HOME}/zlib.tar.gz"
	printf '\n%b\n' " \e[94m\U25cf\e[0m Extracting zlib"
	tar xf "${HOME}/zlib.tar.gz" -C "${HOME}"
	cd "${HOME}/zlib" || exit 1
	printf '\n%b\n\n' " \e[94m\U25cf\e[0m Configuring zlib"
	./configure --prefix="${cygwin_path}" --static --zlib-compat
	printf '\n%b\n\n' " \e[94m\U25cf\e[0m Building with zlib"
	make -j"$(nproc)"
	make install
	printf '\n%b\n' " \e[94m\U25cf\e[0m Building with openssl"
	printf '\n%b\n' " \e[94m\U25cf\e[0m Downloading openssl"
	curl -sL "https://github.com/userdocs/qbt-workflow-files/releases/latest/download/openssl.tar.xz" -o "${HOME}/openssl.tar.xz"
	printf '\n%b\n' " \e[94m\U25cf\e[0m Extracting openssl"
	tar xf "${HOME}/openssl.tar.xz" -C "${HOME}"
	cd "${HOME}/$(tar tf openssl.tar.xz | head -1 | cut -f1 -d"/")" || exit 1
	printf '\n%b\n\n' " \e[94m\U25cf\e[0m Building openssl"
	./config --prefix="${cygwin_path}" threads no-shared no-dso no-comp
	make -j"$(nproc)"
	make install_sw
fi

printf '\n%b\n\n' " \e[94m\U25cf\e[0m Cloning iperf3 git repo"

[[ -d "$HOME/iperf3_build" ]] && rm -rf "$HOME/iperf3_build"
git clone "https://github.com/esnet/iperf.git" "$HOME/iperf3_build"
cd "$HOME/iperf3_build" || exit 1

printf '\n%b\n' " \e[92m\U25cf\e[0m Setting iperf3 version to file iperf3_version"
sed -rn 's|(.*)\[(.*)],\[https://github.com/esnet/iperf],(.*)|\2|p' configure.ac > "$HOME/iperf3_version"

printf '\n%b\n\n' " \e[94m\U25cf\e[0m Bootstrapping iperf3"

./bootstrap.sh

printf '\n%b\n\n' " \e[94m\U25cf\e[0m Configuring iperf3"
./configure --disable-shared --enable-static --enable-static-bin --prefix="$HOME/iperf3" --host=arm64 CC=aarch64-linux-gnu-gcc

printf '\n%b\n\n' " \e[94m\U25cf\e[0m make"
make -j"$(nproc)"

printf '\n%b\n\n' " \e[94m\U25cf\e[0m make install"
[[ -d "$HOME/iperf3" ]] && rm -rf "$HOME/iperf3"
make install

if [[ -d "$HOME/iperf3/bin" ]]; then
	printf '\n%b\n' " \e[94m\U25cf\e[0m Copy dll dependencies"
	[[ -f "${cygwin_path}/bin/cygwin1.dll" ]] && cp -f "${cygwin_path}/bin/cygwin1.dll" "$HOME/iperf3/bin"
	printf '\n%b\n' " \e[92m\U25cf\e[0m Copied the dll dependencies"
fi
