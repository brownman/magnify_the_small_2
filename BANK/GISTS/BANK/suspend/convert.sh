#!/bin/bash
#depend: xsel 
#info: 
clear
set_env(){
    dir_self=`pwd`
    file_target=$dir_self/suspend.sh
    file_sudoers=/etc/sudoers
}


permission(){
    file=$file_target
    user=root
    #$LOGNAME
    ls -l $file
    ls -l $file | grep root --color=auto
    sudo chown $user $file
    sudo chgrp $user $file
}

sudoers(){
    sudo cat $file_sudoers | grep $file_target --color=auto
    local res=$?
    if [ $res -eq 0 ];then
    echo "[mission already accomplished] your $file_sudoers is up-to-date"    
    else

    local cmd="ALL    ALL = (root) NOPASSWD: $file_target" 
clip
    fi

}
clip(){

    echo
    echo "[CLIPBOARD UPDATED]"
    echo "$cmd"
    echo
    echo "[info] now we need to update the file: $file_sudoers"
    echo "[please run] sudo visudo and paste the clipboard content"
    echo "$cmd" | xsel --clipboard
    echo "[clipboard] updated !"


}
present(){
    type set_env
    type permission 
    type sudoers
}
steps(){
#    present
    set_env
    permission
    sudoers
}
steps
