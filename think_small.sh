clear
sourcing(){
source $dir_self/CFG/config.cfg
source $dir_self/CONF/env.cfg
}
set_env(){
    export dir_self=`pwd`
    echo "[dir_self]: $dir_self"
    export file_list=$dir_self/priorities
    echo "[file_list]: $file_list"
    dir_gist=$dir_self/BANK/GISTS/BANK
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
            file_task=$dir_gist/${task_name}.sh
            #[ -s "$file_task" ] && { eat "$file_task" ;} || { echo "[file not exist] $file_task";ls -l $file_task; }
            if [ -f "$file_task" ];then
                if [ "$args" ];then
                    eat "$file_task $args"
                else
                    echo no args
                    eat $file_task
                fi
            else
                print_color 31 "[Error] file not found"
                notify-send error file_not_found
                exit
            fi

        else 
            echo breaking
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
overview(){
    $dir_self/standards.sh
}
present(){
$dir_self/self_present.sh
}


steps(){
    set_env
    sourcing
    overview
    sleep 10
    loop
}

export -f trap_err
steps
