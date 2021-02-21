/* very simple example to illustrate synchronous channels*/

chan chan1=[0] of {bit};


proctype Node1()
{bit message;
chan1!message;
stop:skip
}

proctype Node2()
{bit message;
label1:skip;
chan1?message;
label2:skip;
}

init{run Node1();run Node2()}