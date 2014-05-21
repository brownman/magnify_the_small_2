#http://www.commandlinefu.com/commands/view/10275/search-commandlinefu-and-view-syntax-highlighted-results-in-vim#comment
#
#http://vim.wikia.com/wiki/Folding
#manual: set fdm=marker
#update .gvimrc:
#augroup vimrc
#  au BufReadPre * setlocal foldmethod=marker
#  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
#augroup END

str=$1
t=/tmp/snippet
[ -f $t ] && rm $t
file_new=${t}_${str}

until [[ -z $1 ]]; do
    echo -e "\n# $1 {{{1" >> $t;
    curl -L -s "commandlinefu.com/commands/matching/$1/`echo -n $1|base64`/plaintext" | sed '1,2d;s/^#.*/& {{{2/g' | tee -a $t > $t.c;
    sed -i "s/^# $1 {/# $1 - `grep -c '^#' $t.c` {/" $t;
    shift;
done;






cp  $t $file_new
echo "vim -u /dev/null -c \"set ft=sh fdm=marker fdl=1 noswf\" -M $file_new" | xsel --clipboard;
#rm $t $t.c
