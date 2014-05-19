#about: magnify the small is a framework
#goal:  it increase motivation regarding of keeping nice code snippets 
#use:   update them on daily basis - and let them fullfil thier potential - much like you :)
#motivation: magnify the small is just about giving life to your dreams
#is_it_for_me:   
#mantra: dare to imagine for a complete second / push forward / magnify the small / be cool and relax /do for others first / chase your dreams
toilet1(){
    toilet --gay  "$@"
}
pv1(){
    echo "$@" | pv -qL 10

}
pv1 "Magnify the small"
echo -n "Version:"
pv1 "0 . 0 . 1" 
echo "[press control+c to update a gist] you have 10 seconds"
sleep 1
clear
cat -n $0 | grep "#"  | grep -v grep
echo
echo

