
lsof -i > /tmp/boss_secure_lsofi

com1='zenity --title="List of Opened Applications in the system" --height=500 --width=600 --list --separator=":" --text "Please select the following Applications for stoping in this system or\n Deselect to avail that service in this system" --checklist --column="Select" --column="Available Applications in this system"'

while read line
do

FIELD=`echo $line | awk '{ print $1 "\t" $2 "\t" $3 "\t" $8 }'`
com2=" \"\" \"$FIELD\" "
com1=$com1$com2

done < /tmp/boss_secure_lsofi

eval "$com1"
