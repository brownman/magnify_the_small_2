#!/usr/bin/env bash
set -o nounset
#set -e provides another error mechanism
print_error(){
    echo trapping an error - for signal EXIT
	echo "there was an error"
    exit
}
trap 'echo Error at line ${LINENO};exit 0' ERR

trap print_error exit #list signals to trap
tempfile=`mktemp`
#trap "rm $tempfile" exit
./other.sh || echo warning: other failed
echo oops)
echo never printed
