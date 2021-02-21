/* example 2 */
proctype A(){
    bit x=0;
    bit y=0;
    start:
        if
        ::x++
        ::y++
        fi;
    goto start
}
init {run A()}