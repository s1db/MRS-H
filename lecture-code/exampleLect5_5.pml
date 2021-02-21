/*example to illustrate inline functions*/

chan k1 =[1] of {bit};

byte m=1;


inline min(one,two,minimum)
{if
::one >two -> minimum = two
::else->minimum=one
fi}

proctype A(byte selfid)
{byte c;
bit x;
min(m,selfid,c);
if
::(c==selfid)->k1!1
::else->k1?x;assert(x==1)
fi
}

init{atomic{run A(0);run A(2)}}
