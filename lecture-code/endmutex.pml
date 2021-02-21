/*the user processes are terminating*/
/*try using do..od instead of if..fi*/
/*add endlabel before the do..od in semaphore proctype */

#define p 0
#define q 1
chan sema=[0] of {bit};


proctype semaphore()
{byte count=1;
do
::(count==1)->sema!p;count=0
::(count==0)->sema?q;count=1
od
}

proctype user(byte selfid)
{if
::sema?p;
/*critical section */
  sema!q;
/*non-critical section*/
fi
}

init
{atomic{run semaphore();run user(0);run user(1);run user(2)}}
