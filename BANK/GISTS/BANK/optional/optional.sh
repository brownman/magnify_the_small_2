#depend_package: zenity
#zenity --notification\
#     --window-icon="info" \
#       --text="There are system updates necessary!"

set -e
set -o nounset



text="${1:-text0}"
shift
cmd="${@:-xcowfortune}"

step1(){
echo "[cmd will be] $cmd"
cmd1="zenity \
    --notification \
    --window-icon=info \
    --text '$text' \
    --timeout 10"
echo $cmd1
eval "$cmd1"  && { echo $cmd; eval "$cmd" ; } || { echo "[skip] $cmd" ;} 
}
step1

echo end_of_single
