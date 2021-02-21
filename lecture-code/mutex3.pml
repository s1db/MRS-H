/*simlple mutual exclusion (Dijkstra) */
/*see lecture 5*/
/*another approach to solving example lecture 9 */
/*using a global queue*/


#define p 0
#define q 1
chan sema=[0] of {bit};
chan queue=[3] of {bit};

active proctype semaphore()
{byte count=1;
do
::(count==1)->sema!p;count=0
::(count==0)->sema?q;count=1
od
}

proctype user()
{do
::atomic{sema?p;
	queue!1;}
/*critical section */
atomic{sema!q;
queue?1}    
/*non-critical section*/
od
}



#define q (len(queue)<=1)
#include "claim9"
