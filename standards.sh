#!/bin/bash
set -o nounset


toilet2(){
    local str="$@"
toilet --gay "$str"
}
set_env(){
reset
echo -n '' > /tmp/edit
echo -n '' > /tmp/file_not_found
tag=${1:-info}
dir_self=`dirname $0`
source $dir_self/CFG/print_color.cfg
source $dir_self/CFG/file_to_menu.cfg
dir_gist=$dir_self/BANK/GISTS/BANK
}

grepping(){

toilet2 $tag
#tree $dir_gist
dirs=`ls -d $dir_gist/*`
for dir in $dirs;do
    dirname=`basename $dir`
    file=$dir/$dirname.sh
    filename=`basename $file`
    taskname=`echo $filename | cut -d'.' -f1`
    if [ -f $file ];then
        str=`cat $file | grep $tag | sed "s/$tag//g"`
        if [ -n "$str" ];then
            print_color 32 "\t$str"  
        else
            print_color 31 "$file" >> /tmp/edit 
        fi
    else

            print_color 33 "$taskname|$file" >> /tmp/file_not_found
    fi


done


}
summary(){
#cmd="cat /tmp/edit | zenity --list -column file --print_column=1 --title 'Update Readiness level'"
file_to_menu /tmp/edit
#
}
steps(){
    set_env

    grepping
#[ $SHLVL = 1 ] && {    summary; }
cat /tmp/edit
cat /tmp/file_not_found
}
steps
