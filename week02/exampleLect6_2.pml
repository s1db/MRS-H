/*simlple mutual exclusion (Dijkstra) */
/*see end of lecture 6*/


#define p 0
#define q 1
chan sema=[0] of {bit};

active proctype semaphore()
{byte count=1;
do
::(count==1)->sema!p;count=0
::(count==0)->sema?q;count=1
od
}

active proctype user1()
{progress:do
::sema?p;
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

/*active proctype user3()*/
/*do*/
/*::sema?p;*/
/*critical section */
/*sema!q*/
/*non-critical section*/
/*od*/
/*}*/
