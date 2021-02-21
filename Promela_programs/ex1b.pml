init { /* example 1b */
byte i = 0;
do
::atomic{(i==10)->break}
::atomic{else->i = i+1}
od
}