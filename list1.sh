clear
exec 2>/tmp/err
trap trap_err ERR
file_reminder=$dir_self/.old/reminders.txt

trap_err(){
    str_caller=`caller`

    echo "TRAPPING ERROR"
    echo "[str_caller] $str_caller"

    local cmd0="gvim ${file_last}"
    #cmd0="$file_last"
    local cmd=$( gxmessage -entrytext "$cmd0" -file /tmp/err )
    eval "$cmd"
}
set_env(){
    export dir_self=`pwd`
    echo "[dir_self]: $dir_self"
    export file_list=$dir_self/priorities
    echo "[file_list]: $file_list"
    source env.cfg
}
eat(){
    local    cmd="$@"

    local    max="$#"
    echo "[cmd] $cmd"
    echo "[max] $max"

    eval   "$cmd" 
    sleep  2
}


single(){
   local task_name=''
   local args=()
            local file_task=''
            local str_depend=''

    while read line;do
        if [ -n "$line" ];then
            task_name=$( echo $line | cut -d' ' -f1 )
            args=$( echo $line | cut -d' ' -f2- )
            file_task=$dir_self/SINGLES/BANK/$task_name/${task_name}.sh
            #[ -s "$file_task" ] && { eat "$file_task" ;} || { echo "[file not exist] $file_task";ls -l $file_task; }
            str_depend=$(            cat $file_task | grep depend_package )
            if [ $str_depend ];then
            echo "[DEPANDENCIES] $str_depend"
            else
                zenity --alert=error "add tag: #depend_package:"

                #trace gvim $file_task &
            fi

            if [ "$args" ];then
            eat "$file_task $args"
        else
            echo no args
            eat $file_task
        fi
        else 
            break
        fi

    done<$file_list
}

loop(){
    local counter=1
    while :;do
        flite -t "round $counter"
        xcowsay "round $counter"
        single
        let 'counter += 1'
    done
}
steps(){
    set_env
    loop
}

export -f trap_err
steps
