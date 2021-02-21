chan queue=[1] of {mtype};
mtype ={token}
short p0=-1;
short p1=-1;
proctype A()
{bit x=0;
start:x++;
mywait:queue?token;queue!token;x--;
stop:goto start
}

init
{queue!token;
 p0=run A();
 p1=run A()}

#define p (A[p0]@mywait)
#include "claim2"

