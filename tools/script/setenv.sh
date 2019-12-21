#!/bin/bash
##########################################################
# File Name		: setenv.sh
# Author		: winddoing
# Created Time	: 2019年09月02日 星期一 14时44分49秒
# Description	: Support centos7 and ubuntu18.04
##########################################################

PWD=`pwd`
OUTPUT="${PWD}/out"


function concatenate_colon {
    OLD_IFS="$IFS"
    IFS=" "
    local array=($@)
    local val

    for str in ${array[@]}
    do
        if [ "$val" ]; then
            val=$val:$str
        else
            val=$str
        fi
    done

    echo "$val"
}

function add_export_env {
    local VAR="$1"
    shift
    local VAL=$(eval echo "\$$VAR")
    if [ "$VAL" ]; then
        VAL=$(concatenate_colon "$@" "$VAL");
    else
        VAL=$(concatenate_colon "$@");
    fi
    echo "export $VAR=\"$VAL\""
    eval "export $VAR=\"$VAL\""
}

function prefix_setup {
    local PREFIX="$1"

    add_export_env PATH "$PREFIX/bin"
    add_export_env LD_LIBRARY_PATH "$PREFIX/lib" "$PREFIX/lib/x86_64-linux-gnu" "$PREFIX/lib/aarch64-linux-gnu"  "$PREFIX/lib64"
    add_export_env PKG_CONFIG_PATH "$PREFIX/lib/pkgconfig/" "$PREFIX/lib/x86_64-linux-gnu/pkgconfig/" "$PREFIX/lib/aarch64-linux-gnu/pkgconfig" "$PREFIX/lib64/pkgconfig" "$PREFIX/share/pkgconfig/"
    add_export_env MANPATH "$PREFIX/share/man"
    export ACLOCAL_PATH="$PREFIX/share/aclocal"
    mkdir -p "$ACLOCAL_PATH"
    export ACLOCAL="aclocal -I $ACLOCAL_PATH"
    echo "ACLOCAL=$ALT_LOCAL"
}

function projectshell {
    case "$1" in
        virgl | virglrenderer)
            export ALT_LOCAL="${OUTPUT}"
            mkdir -p "$ALT_LOCAL"
            prefix_setup "$ALT_LOCAL"
            ;;
    esac
}

function whether_setenv {

    if [ ! -n "$ALT_LOCAL" ]; then
        echo "[ALT_LOCAL] is NULL"
        return 1;
    fi

    local path=$PATH
    OLD_IFS="$IFS"
    IFS=":"
    local array=($path)
    local mbin="$OUTPUT/bin"

    for str in ${array[@]}
    do
        if [ x"$str" == x"$mbin" ]; then
            return 0;
        fi
    done

    return 1;
}

whether_setenv
if [ "$?" -eq "0" ]; then
    echo "The environment variable has been initialized ..."
    echo "[ALT_LOCAL] is ${ALT_LOCAL}"
    return 0;
fi

projectshell virgl
echo "[ALT_LOCAL] is ${ALT_LOCAL}"
export is_source=1
