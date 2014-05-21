#!/bin/bash
#info: run translate.sh with many langs for 1 input
set -o nounset
pushd `dirname $0`>/dev/null

str="$@"
if [ -n "$str" ];then
    while read line;do
        cmd="./translate.sh "$line" \"$str\""
        echo "[cmd] $cmd"
        eval "$cmd"
    done < languages.txt
else
    echo "[Error] string is empty"
fi

popd >/dev/null
