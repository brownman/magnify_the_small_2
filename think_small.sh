clear
#exec 2>/tmp/err

#trap trap_err ERR
set -o nounset
update_clipboard(){
    ok updating clipboard
    echo "$@" | xsel --clipboard
}
trap_sigint(){
    if [ -n "$file_current" ];then
        update_clipboard "vi $file_current"
    else
        error wait - idiot
    fi
    exit 0

}


ok()(
local str=`echo $@`
print_color 32 "$str"
)
super()(
local str=`echo $@`
print_color 35 "$str"
)


error()(
local str=`echo $@`
print_color 31 "$str"
)
warn()(
local str=`echo $@`
print_color 33 "! $str"
)
toilet1(){
    toilet --gay  "$@" 
}
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

    type print_color &>/dev/null && { error trap_err; } || { echo TRAP ERROR; }
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
    file_current=""
    export dir_self=`where_am_i $0`
    echo "[dir_self]: $dir_self"
    if [  -n "$input" ];then
        #depend_var: input
        export file_list=/tmp/list_test_task
        echo "$input" > /$file_list
    else

        export file_list=$dir_self/priorities
    fi



    echo "[file_list]: $file_list"
    dir_gist=$dir_self/BANK/GISTS/BANK

}

run_task(){
    local  task="$1"
    local  params="${2:-}"
    local  file="$dir_gist/$task/$task.sh"
file_current="$file"
    sleep 2

    if [ -f $file ];then
        local cmd="$file $params" 
        super  "[Running Task] $cmd"
        eval "$cmd"
    else
        error "file not found: $file"
    fi
}
single(){
    echo '[single]'
    #    trap trap_err ERR
    #    exec 2>/tmp/err
    local task_name=''
    local args=()
    local file_task=''
    local str_depend=''
    local arr=()
    local file=''
    local task=''
    echo loop over the fils
    while read line;do
        if [ -n "$line" ];then
            task=$(            echo "$line" | cut -d ' ' -f1 )
            params=$(             echo "$line" | cut -d ' ' -f2- )
            cmd="run_task \"$task\" \"$params\""
            echo "[cmd] $cmd" 
            eval "$cmd"
        else
            warn "file has empty line: $file_list"
        fi
    done < $file_list
}

loop(){
    echo "[loop]"
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

print_priorities(){
    toilet1 Priorities 
    cat $file_list
}
print_big_picture(){
    echo "Magnify the small is all about daring to start - even the smallest step is counted and appriciated !"
    echo 'update static txt: TXT/'
    echo 'use task: add_snippet to collect more wisdom'
    echo 'collect your edits at WORKSPACE/'
}
steps(){
    set_env
    print_big_picture 
    print_priorities
    sourcing
    #    present
    #    overview
    if [ -n "$input" ];then
        single

    else
        loop
    fi

}
#trap 'trap_err' ERR
#export -f trap_err

trap trap_sigint SIGINT
input=${@:-}
echo "[input] $input"
steps
