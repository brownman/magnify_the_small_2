clear
exec 2>/tmp/err
set -o nounset
where_am_i () 
{ 
    local file=${1:-"${BASH_SOURCE[1]}"};
    local rpath=$(readlink -m $file);
    local rcommand=${rpath##*/};
    local str_res=${rpath%/*};
    local dir_self="$( cd $str_res  && pwd )";
    echo "$dir_self"
}

trap_err(){
    str_caller=`caller`

    type print_color &>/dev/null && { print_color 31 "TRAPPING ERROR"; } || { echo TRAP ERROR; }
    echo "[str_caller] $str_caller"

    local cmd0="gvim +${str_caller}"
    #cmd0="$file_last"
    local cmd1="gxmessage -entrytext \"$cmd0\" -file /tmp/err"
    echo "$cmd1"
    cmd2=$(    eval "$cmd1" )
    eval "$cmd2"
    exit 0
}






sourcing(){
    source $dir_self/CFG/print_color.cfg
    source $dir_self/CONF/vars.conf
    #source $dir_self/CFG/trap_err.cfg
}
set_env(){
    export dir_self=`where_am_i $0`
    echo "[dir_self]: $dir_self"
    export file_list=$dir_self/priorities
    echo "[file_list]: $file_list"
    dir_gist=$dir_self/BANK/GISTS/BANK

}

single(){
 trap trap_err ERR
    local task_name=''
    local args=()
    local file_task=''
    local str_depend=''
    local arr=()
    while read line;do
        if [ -n "$line" ];then
            echo "$line"
            arr=(  $line )
            echo "${#arr[@]}"
            task="${arr[0]}"
            file=$dir_gist/$task/$task.sh


            unset arr[0]              ## remove element
            array=( "${arr[@]}" )     ## pack array

            args="${arr[@]}"
            args1="${args:-}"

            if [ -f "$file" ];then
                eval "$file $args1"
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

    #    present
    #    overview
    loop
}
trap 'trap_err' ERR
export -f trap_err

steps
