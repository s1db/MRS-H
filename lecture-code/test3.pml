/*A simple example of the use of a never-claim*/

byte x=0;
byte y=1;

active proctype A()
{if
::(x==0)->x++;y++
fi
}

active proctype B()
{if
::(x==1)->x--;y--
fi
}

#define p (x==0)
#define q (y==1)

/*#include "claim1"  */
 ltl newClaim1 {[](p->q)}
/*ltl newClaim2 { [] p } */

