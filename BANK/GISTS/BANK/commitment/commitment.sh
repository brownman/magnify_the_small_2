#depend_package: yad gxmessage
set -e
set -o nounset
update_file(){
    local     file=$1
    local     line="$2"
    echo -e "$line" >> $file
}
progress_bar () 
{ 
    local sec=${delay:-60};
#    local title=Focus;
    local min=$((sec/60));
    title="${1:-focus}";
    text="${min}m"

    #text="${min}m :: $text";
    title=" $title ";
    local num=0;
    ( echo "sleep ${sec}s";
    for ((c=1; c<=$sec; c++ ))
    do
        num=$((c*100/sec));
        echo "$num";
        /bin/sleep 1s;
    done ) | yad --progress --percentage=10 --progress-text="$text" --title="$title" --sticky --on-top --auto-close
}

update_commitment(){
    local time1=`date | tr -s ' ' | cut -d' ' -f4 | cut -d':' -f1,2 `
    local cmd=""
    export GXMESSAGE='-ontop -sticky -wrap -timeout 10'
#    while [ -z "$line" ];do
        flite -t "next easy mission"
        cmd="gxmessage -entrytext \"$line\" -title 'Focus' -file $file_done $GXMESSAGE"

        line=$(    eval "$cmd" )
  #  done
    local line_new="$time1\t$line"
    update_file $file_done "$line_new"
    show_progress
}
show_progress(){
    local            cmd="progress_bar \"$line\"" 
    local str=$( eval "$cmd" )
    local res=$?

}
#unlocker
file_done=/tmp/done.txt
[ ! -f $file_done ] && { touch $file_done ;}
delay=${1:-60}
line="${2:-}"
if [ -z "$line" ];then
update_commitment
else
show_progress
fi


