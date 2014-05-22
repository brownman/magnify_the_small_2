
set -o nounset
mhtml() { [[ -f "$file" ]] || return 1; 
#    vim -X +'syn on | run! syntax/2html.vim | wq | q' "$file";
#vim -f +"syn on" +"colorscheme slate" +"TOhtml" +"wq" +"q" "$file"
vim -X -e -f +"syn on" +"TOhtml" +"wq" +"q" "$file"
}
file=${1:-/tmp/snippet}
target=/tmp/snippet.html
mhtml $file 

if [ -f "$target" ];then
echo "google-chrome $target"
else
echo "file not found: $file"
fi

