cat  /tmp/boss_secure_lsofi | xargs -0 echo |  awk '{ print $1 "\t" $2 "\t" $3 "\t" $8 }'

