echo $0
sleep 1
pushd `dirname $0` >/dev/null

GXMESSAGE2="-ontop -sticky -timeout 20"
set -o nounset
fu_cmd () 
{ 
    curl "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext"
}

steps(){


local file=/tmp/snippet
touch $file

local str=$( gxmessage -entry -title "Add Snippet" -file /tmp/snippet $GXMESSAGE2 )

#./fu2.sh "$str"
[ -n "$str" ] && ./text2html.sh snippet


}
steps
popd >/dev/null
