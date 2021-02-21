/*extension of mutex1.p*/
/*added global variables to record who is in critical section*/

#define p 0
#define q 1
chan sema=[0] of {bit};
bool incritical[3]=false;

proctype semaphore()
{byte count=1;
do
::(count==1)->sema!p;count=0
::(count==0)->sema?q;count=1
od
}

proctype user(byte selfid)
{do
::atomic{sema?p;
  incritical[selfid]=true}
/*critical section */
  atomic{incritical[selfid]=false;sema!q}
/*non-critical section*/
od
}

init
{atomic{run semaphore();run user(0);run user(1);run user(2)}}

#define r (incritical[0]==true)
#define s (incritical[1]==true)
#define t (incritical[2]==true)

ltl property1  { [] (! ( (r && s) || (r && t) || (s && t) ) ) }
