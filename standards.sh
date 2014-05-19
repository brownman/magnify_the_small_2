#!/bin/bash
reset
set -o nounset

tag=${1:-info}
dir_self=`dirname $0`

source $dir_self/CFG/print_color.cfg
dir_gist=$dir_self/BANK/GISTS/BANK
#tree $dir_gist
dirs=`ls -d $dir_gist/*`
for dir in $dirs;do
    dirname=`basename $dir`
    file=$dir/$dirname.sh
    if [ -f $file ];then
str=`cat $file | grep $tag | sed "s/$tag//g"`
if [ -n "$str" ];then
  print_color 32 "\t$str"  
else
  print_color 31 "\tvi $file"  
fi
    
    fi


done

