/*simlple mutual exclusion (Dijkstra) */
/*see lecture 5*/


#define p 0
#define q 1
chan sema=[0] of {bit};
byte criticalCount=0;

active proctype semaphore()
{byte count=1;
do
::(count==1)->sema!p;count=0
::(count==0)->atomic{sema?q;criticalCount--};count=1
od
}

active proctype user0()
{do
::atomic{sema?p;
	criticalCount++};
/*critical section */
sema!q;
/*non-critical section*/
od
}

active proctype user1()
{do
::atomic{sema?p;
               criticalCount++};
/*critical section */
sema!q;     
/*non-critical section*/
od
}

#define r (criticalCount<=0)

ltl property1 {[] r}
