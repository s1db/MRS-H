byte winner = -1;
mtype = {null, scissors, stone, paper}
chan queue = [2] of {mtype};
chan zero = [1] of {bit};
chan one = [1] of {bit};
/* Players */
proctype A (byte selfid; chan chan_in){
    start:
    (len(queue)==selfid) ->
    if
    :: queue!scissors /*scissors*/
    :: queue!stone /*stone*/
    :: queue!paper /*paper*/
    fi;
    chan_in?1;
    goto start
}
proctype controller(){
    mtype x,y;
    do
    :: full(queue)->
    queue?x; /*proc 0's try*/
    queue?y; /*proc 1's try*/
    if
    :: (x==scissors)->
        if
        ::(y==scissors)->printf("No winner, try again");winner=3
        ::(y==stone)->printf("Proc 1 wins");winner=1
        ::(y==paper)->printf("Proc 0 wins");winner=0
        fi
    :: (x==stone)->
        if
        ::(y==scissors)->printf("Proc 0 wins");winner=0
        ::(y==stone)->printf("No winner, try again");winner=3
        ::(y==paper)->printf("Proc 1 wins");winner=1
        fi
    :: (x==paper)->
        if
        ::(y==scissors)->printf("Proc 1 wins");winner=1
        ::(y==stone)->printf("Proc 0 wins");winner=0
        ::(y==paper)->printf("No winner, try again");winner=3
        fi
    fi;
    zero!1;one!1
    od
}
init{run A(0,zero); run A(1,one); run controller()}
