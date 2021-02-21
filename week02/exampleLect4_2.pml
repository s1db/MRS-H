proctype A(){
bit count=0;
do
:: count==0 -> count++
::else->count--
od;
}

init{run A()}
