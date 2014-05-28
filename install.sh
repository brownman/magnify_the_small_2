
packages=`cat dependencies.txt`
for package in $packages;do
cmd="yaourt -S --noconfirm $package"
pacman -Q $package || { eval "$cmd" 1>/tmp/out; cat /tmp/out; } 
done

