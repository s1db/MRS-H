/*An extension to simple example of the use of a never-claim*/

byte x=0;
byte y=1;
mtype ={token}
chan queue = [1] of {mtype};

active proctype A()
{mtype z;
if
::atomic{(x==0)->x++;queue?z;y++}
fi
}

active proctype B()
{mtype z;
if
::atomic{(x==1)->x--;queue?z;y--}
fi
}

active proctype C()
{mtype z= token;
do
::queue!z
od
}


#define p (x==0)
#define q (y==1)

#include "claim1"
