set -o nounset
step0(){
    dir_txt=/tmp
    dir_mp3=/tmp
    dir_html=/tmp
}
step1() {
    echo "input: $input"
    input_wsp=$(echo "$input"|sed 's/ /+/g');
    input_ws=$(echo "$input"|sed 's/ /_/g');
    file_txt=$(  echo $dir_txt/${input_ws}_${lang}.txt );
    file_mp3=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 );
    file_html=$(  echo $dir_html/${input_ws}_${lang}.html );
    file_mp3=$(  echo $dir_mp3/${input_ws}_${lang}.mp3 );
    echo "input_wsp: $input_wsp";
    echo "file_mp3:  $file_mp3";
}

step2(){
    result=''
    if [ "$input_wsp" ];then
        result=$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$input_wsp&sl=en&tl=$lang" ) 
        if [ "$result" ];then
            #echo "$result" >> $TODAY_DIR/translate.json
            cleaner=$(echo "$result" | sed 's/\[\[\[\"//') 
            #trace "$result"
            phonetics=$(echo "$cleaner" | cut -d \" -f 5)
            output=$(echo "$cleaner" | cut -d \" -f 1)
            output_wsp=$(echo "$output"|sed 's/ /+/g');
            output_ws=$(echo "$output"|sed 's/ /_/g');
            echo "$output"
            notify-send "$output"
            if [ "$phonetics" ];then
                echo  "$phonetics"
                notify-send "$phonetics"
            fi  
        else
            reason_of_death 'no results'
        fi
    fi
}

step3(){
    local cmd=''
    local size=0
    if [ ! -s "$file_mp3" ];then
        wget -U Mozilla -q -O - "$@" translate.google.com/translate_tts?ie=UTF-8\&tl=${lang}\&q=${output_wsp} > $file_mp3 
    else
        echo "[Exist] use cached file"
    fi
    size=`wc --b $file_mp3 | cut -d' ' -f1`
    echo "[size] $size"
    if [ -s $file_mp3 ] && [ $size -gt 0 ];then 
        cmd="play -V1 -q  $file_mp3"
        #    mpg321 $file_mp3 1> /dev/null
        eval "$cmd" 
    else
        echo "[Error] empty file: $file_mp3 "
    fi
}
steps(){
    step0
    step1
    step2
    step3
}
if [ $# -gt 1 ];then
    lang="$1"
    shift
    input="$@"
    steps  
else
    echo reason_of_death "need 2 arguments - got $#"
fi

