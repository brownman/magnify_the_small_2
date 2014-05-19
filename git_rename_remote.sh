echo The closest thing to renaming is deleting and then re-creating on the remote. You can do this by eg:

echo rename localy  - git branch -m master master-old
echo delete master - git push remote :master # delete master
echo push the locally renamed branch : branch_old - git push remote master-old # create master-old on remote
echo git checkout -b master some-ref # create a new local master
echo finally - git push remote master # create master on remote
