Bash’s Pseudo Functions
 
Since you can’t really pass pointers or references to arrays and you can’t return anything other than integers, here’s how to implement push, pop, shift, and unshift in a bash shell script.
Push
 
arr_push() { arr=("${arr[@]}" "$1") }
1
2
3
       
arr_push() {
  arr=("${arr[@]}" "$1")
}
 
Pop
 
arr_pop() { i=$(expr ${#arr[@]} - 1) placeholder=${arr[$i]} unset arr[$i] arr=("${arr[@]}") }
1
2
3
4
5
6
       
arr_pop() {
  i=$(expr ${#arr[@]} - 1)
  placeholder=${arr[$i]}
  unset arr[$i]
  arr=("${arr[@]}")
}
 
Shift
 
arr_shift() { arr=("$1" "${arr[@]}") }
1
2
3
       
arr_shift() {
  arr=("$1" "${arr[@]}")
}
 
Unshift
 
arr_unshift() { placeholder=${arr[0]} unset arr[0] arr=("${arr[@]}") }
1
2
3
4
5
       
arr_unshift() {
  placeholder=${arr[0]}
  unset arr[0]
  arr=("${arr[@]}")
}
 
This won’t be so bad if you’re just using one array since you’re coding the array directly into the functions, but it’s obviously not going to scale!
Test Time!
 
Now for some wicked simple examples…
Start with a three element array called “arr”. I’ll use some string numbers to make it obvious which index of the array they belong in.
 
arr=("one" "two" "three") echo ${arr[@]}
1
2
       
arr=("one" "two" "three")
echo ${arr[@]}
 
    one two three
 
Put a “zero” at the beginning and a “four” on the end.
 
arr_shift "zero" arr_push "four" echo ${arr[@]}
1
2
3
       
arr_shift "zero"
arr_push "four"
echo ${arr[@]}
 
    zero one two three four
 
Drop the first element, “zero”, by unshifting.
 
arr_unshift echo ${arr[@]}
1
2
       
arr_unshift
echo ${arr[@]}
 
    one two three four
 
Pop off the last element, “four”, by popping.
 
arr_pop echo ${arr[@]}
1
2
       
arr_pop
echo ${arr[@]}
 
    one two three
 
If you want to hold onto the values of unshift and pop, you can look at the placeholder variable. It keeps the last element that was removed.
