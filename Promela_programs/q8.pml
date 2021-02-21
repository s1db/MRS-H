byte y;
proctype A(){
    byte x;
    loop:
        if
        ::(x==y)->skip
        ::atomic{else->x++;goto loop}
        fi
}
init{atomic{run A();y=3}}