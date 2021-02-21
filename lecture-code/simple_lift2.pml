#define N 2 /* number of people */
#define M 3 /*number of choices of floor */
byte mychoice[N]=M;
chan button = [1] of {byte,byte}; /*requested channel and id */
byte at_floor=0; /*current position of lift*/
chan mytoken[N]=[0] of {bit};

proctype person(byte selfid)
{ bit x=0;
  do
  ::if
::atomic{button!0,selfid;mychoice[selfid]=0}
::atomic{button!1,selfid;mychoice[selfid]=1}
::atomic{button!2,selfid;mychoice[selfid]=2}
    fi;
    atomic{mytoken[selfid]?x;
    assert(x==1);
    assert(at_floor==mychoice[selfid]);
    mychoice[selfid]=M}
  od}

proctype lift()
{byte temp=M;
 byte personid=N;

 do
::button?temp,personid;
  at_floor=temp;/*go to requested floor*/
  mytoken[personid]!1;
  temp=M;
  personid=N
od}

#define p (mychoice[0]==2)
#define q (at_floor==2)
#include "alicelift1.ltl"

init {
   atomic {
	    run lift(0);
	  run person(0);
	  run person(1);
	 }}