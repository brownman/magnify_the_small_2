set -o nounset
mhtml() { [[ -f "$file" ]] || return 1; 
    vim -X +'syn on | run! syntax/2html.vim | wq | q' "$file";
}
file=${1:-snippet}
mhtml $file 
google-chrome $file.html
