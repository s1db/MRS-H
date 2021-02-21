/*simple mutual exclusion (Dijkstra) */

#define p 0
#define q 1
chan sema=[0] of {bit};

active proctype semaphore()
{byte count=1;progress1:
do
::(count==1)->sema!p;count=0
::(count==0)->sema?q;count=1
od
}

active proctype user1()
{label2: do
::sema?p;label3:
/*critical section */
sema!q
/*non-critical section*/
od
}

active proctype user2()
{do
::sema?p;
/*critical section */
sema!q
/*non-critical section*/
od
}
