byte winner = -1;
chan queue = [2] of {byte};
chan zero = [1] of {bit};
chan one = [1] of {bit};
/* Players */
proctype A (byte selfid; chan chan_in){
    start:
    (len(queue)==selfid) ->
    if
    :: queue!0 /*scissors*/
    :: queue!1 /*stone*/
    :: queue!2 /*paper*/
    fi;
    chan_in?1;
    goto start
}
proctype controller(){
    byte x=0;
    byte y=0;
    do
    :: full(queue)->
    queue?x; /*proc 0's try*/
    queue?y; /*proc 1's try*/
    if
    :: (x==0)->
        if
        ::(y==0)->printf("No winner, try again");winner=3
        ::(y==1)->printf("Proc 1 wins");winner=1
        ::(y==2)->printf("Proc 0 wins");winner=0
        fi
    :: (x==1)->
        if
        ::(y==0)->printf("Proc 0 wins");winner=0
        ::(y==1)->printf("No winner, try again");winner=3
        ::(y==2)->printf("Proc 1 wins");winner=1
        fi
    :: (x==2)->
        if
        ::(y==0)->printf("Proc 1 wins");winner=1
        ::(y==1)->printf("Proc 0 wins");winner=0
        ::(y==2)->printf("No winner, try again");winner=3
        fi
    fi;
    zero!1;one!1
    od
}
init{run A(0,zero); run A(1,one); run controller()}
