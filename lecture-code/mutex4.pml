/*simlple mutual exclusion (Dijkstra) */
/*see lecture 5*/
/* note that this version will no longer work */
/*I think this is due to bug fixes in Spin */
/*flow of control moves from sender to receiver during handshake */
/*communication, so cannot assume that the resetting of incritical value */
/*occurs after second handshake*/
/* WF doesn't help either */
/*see new version, mutex5*/


#define p 0
#define q 1
chan sema=[0] of {bit};
bool incritical[2]=false;

active proctype semaphore()
{byte count=1;
do
::(count==1)->sema!p;count=0
::(count==0)->sema?q;count=1
od
}

active proctype user0()
{do
::atomic{sema?p;
	incritical[0]=true;}
/*critical section */
atomic{sema!q;
incritical[0]=false}    
/*non-critical section*/
od
}

active proctype user1()
{do
::atomic{sema?p;
	incritical[1]=true;}
/*critical section */
atomic{sema!q;
incritical[1]=false}        
/*non-critical section*/
od
}

#define p (incritical[0]==true)
#define q (incritical[1]==true)
#include "claim5"
