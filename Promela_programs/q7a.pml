chan chan1=[1] of {bit};
chan chan2=[1] of {bit};
chan chan3=[1] of {bit};
proctype A(chan selfin, selfout){
    bit x=0;
    do
    ::selfin?x;selfout!x;
    od
}
init{
    chan1!1; 
    run A(chan1, chan2);
    run A(chan2, chan3); 
    run A(chan3, chan1)
} 