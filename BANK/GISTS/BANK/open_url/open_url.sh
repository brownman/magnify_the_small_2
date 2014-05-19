#depend_package: zenity
url="${1:-https://www.google.com/calendar/render}"
title="${2:-calendar}"
step1(){
local cmd="google-chrome '$url'"
(    zenity  --notification  --window-icon=update.png  --text "blessed $title" --timeout 10 && { eval "$cmd" ; } || { echo "[skip] $cmd" ;} )
}
step1

echo end_of_single
