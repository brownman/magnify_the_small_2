#!/bin/bash
#| |__  _   _(_) | |_     (_)_ __  
#| '_ \| | | | | | __|____| | '_ \ 
#| |_) | |_| | | | ||_____| | | | |
#|_.__/ \__,_|_|_|\__|    |_|_| |_|

######################
#built-ins:
# publish as you play - integrated screencast
# translate the output of a task - translate()
# xcowsay - count the rounds
######################
#depend_package: xcowsay
set -o nounset

dir_self=`dirname $0`
pushd $dir_self>/dev/null
exec 2>/tmp/err





trap_err(){
    #depand_package: vim-gtk gxmessage
    #depand_func: print_line print_func
    str_caller=`caller`
    print_line
    print_func
    cat /tmp/err
    cmd="gvim +${str_caller}"
cmd1=$( gxmessage -entrytext "$cmd" -file /tmp/err -title 'trap_err' )
eval "$cmd1"
    exit 0
}

translate_line(){
    local line="$1"
    if [ -n "$line" ];then
        echo 'translating' "$line"
        cmd="$script_translate $lang $line"
        echo "[request translation] $cmd"
        eval "$cmd"
    fi
}

print_line(){
    echo '------------'
}
print_func () 
{ 
    echo "${FUNCNAME[1]}"
}

random_line () 
{ 
    local file=$1;
    if [ -f $file ]; then
        local num=$(       cat $file | wc -l );
        local str=$(cat $file | tail -${num} | head -1);
        echo "$str";
    else
        echo 'file not found: ' "$file";
    fi
}

#gist: mission is to look after me while I am sailing in space time
#depand_package: svn
#later: https://code.google.com/p/yad/wiki/Examples
#how:  use a simple loop , feed it with a simple txt list.
#minimalism: 24
#date: 2/5/2014
#author: ofer shaham (c)
trace(){
    echo $@
}
sleep(){
    num=$1
    /bin/sleep $num
}
progress(){
    local title="${2:-'Focus'}"
    local sec=${1:-60}
    local min=$((sec/60))
    #  local time2='later'
    #$(get_time "$sec")

    #    text="$date1-$time2::
    text=${3:-''}
    text="${min}m :: $text"
    title=" $title "
    local num=0
    ( 
    trace "sleep ${sec}s"
    for (( c=1; c<=$sec; c++ ))
    do  
        #tracen  "$c "
        num=$((c*100/sec))
        #assert_equal_str "$num"
        echo "$num" ;            sleep 1s
    done
    ) | yad --progress --percentage=10 \
        --progress-text="$text" \
        --title="$title" \
        --sticky --on-top \
        --auto-close
}
pulsate(){
    (echo COMMAND;notify-send COMMAND;xcowsay COMMAND;echo COMMAND) | zenity --progress --text="Working hard or hardly working?" --percentage=0 --auto-close
}
ensure_dep(){
    #question: may exist in non-free repo ?
    #url.later: http://wiki.getdeb.net/PackagingGuide/Preparing
    #url.extra:      svn checkout svn://svn.code.sf.net/p/yad-dialog/code/trunk /opt/yad
    type yad &>/dev/null 
    local res=$?
    if [ $res -eq 1 ];then
        file1=yad_0.25.1-1~getdeb1_${arch}.deb
        wget http://ftp.dk.debian.org/getdeb/ubuntu/pool/apps/y/yad/$file1
        sudo dpkg -i $file1
    fi
}
prepare(){
    if [ ! -f $file_list ];then
        touch $file_list
        echo 'list todo' >> $file_list
    fi
}
set_env(){
    #self awareness
    dir=`dirname $0`
    file_list=$dir/list.txt

    #yad
    arc1=amd64.deb
    arc2=i386.deb
    arc=$arc1
    #translation
    script_translate="$dir_self/SINGLES/BANK/translation/translation.sh"
    lang=ru
    SOUND=false
    
export    GXMESSAGE="-ontop -sticky"

}

eat(){

    local args=( $@ )

    print_func
    local max=${#args[@]}
    echo "[max] $max"

    local task_name="${args[0]}"

    local file="$dir_self/SINGLES/BANK/$task_name/${task_name}.sh"
    local cmd=''
    if [ -f "$file" ];then
        if [ $max -gt 1 ];then
            args=( ${args[@]:1} )
            #update_args
            cmd="$file ${args[@]}"
        else
            cmd="$file"
        fi
        echo  -e "\t[cmd] $cmd"



        local line_for_translation=$( exec 2>/tmp/err; trap trap_err ERR; eval "$cmd"  )

        res=$?
        echo "[res] $?"
        translate_line "$line_for_translation"
    else
        echo "[error] file not exist " "$file"
        return 1
    fi


}
breaking(){
    echo break
    break
}
loop(){
    sdiiif
    local counter=1
    while read line;do
        #just in case:
        if [ -n "$line" ];then

        xcowsay "WoW!!!  $counter"
            echo "[$counter]"
            echo "[line] $line"
            eat "$line"
            sleep 1 
        else
            echo encounter empty line
            breaking
        fi


        let 'counter += 1'

    done<$file_list
}

steps(){


    set_env
    prepare
    touch /sdfsdf
    loop
}

export -f trap_err
#trap trap_err ERR
cmd=${1:-steps}
eval "$cmd"
; <<COMMENT

tree -L 3
----------------- ALSO GOOD TO REMEMBER ------------
http://www.cyberciti.biz/faq/tar-extract-linux/
-x : Extract a tar ball.
-v : Verbose output or show progress while extracting files.
-f : Specify an archive or a tarball filename.
-j : Decompress and extract the contents of the compressed archive created by bzip2 program (tar.bz2 extension).
-z : Decompress and extract the contents of the compressed archive created by gzip program (tar.gz extension).
COMMENT
popd
