#define N 2
#define MAX1 8
#define MAX2 2
chan fromA =[N] of {mtype, byte, bit} 
chan toB =[N] of {mtype, byte, bit}
chan fromB =[N] of {byte, bit} 
chan toA =[N] of {byte, bit}
mtype ={error,data,control}
#define FETCH mt=(mt+1)%MAX1
#define NO_ERROR assert(at==(last_at+1)%MAX2)



proctype lower (chan from1, to1, from2, to2)
{ byte d; bit b; 

do
::  from1?data(d,b) -> 
          if
          ::  to2!data(d,b)        /* correct */
          :: skip; progress2:  to2!error(d,b)       /* error */
          fi
:: from2?control(b) ->
          if
          :: to1!control(b)       /* correct */
          :: to1!error(b)          /* error */
          fi
:: from2?error(b) -> to1!error(b)
od
}


/*Sender - with initialisation*/

proctype A (chan chanin, chanout)
{ byte mt=0;		/* message type */
   bit at=1;             /* alternation bit */
   bit vr=1;		/* verification bit */
chanout!data(0,1);	/* initialise */
do  :: chanin?error(vr) -> 	/* an error in ack*/
             chanout!data(0,1)	/* resend */
      :: chanin?control(0) ->   	/*an error in send */
            chanout!data(0,1)	/* resend */
     :: chanin?control(1) -> 	/* successful initialisation */
             break
od;

FETCH;        	/* get actual data */
chanout!data(mt,at);	/* send the data */
do		/* wait for correct response */
:: chanin?control(vr) ->    	/* got a control message */
       if
       :: (vr == at) ->	/* correct ! */
             FETCH;             	/* get next actual data */
           progress1: at = at-1;	/* alternate status bit */
             vr = at;
      :: (vr != at) ->             /*  an error in send */
             skip 	/* do nothing, resend */
      fi;
      chanout!data(mt,at)        	/* send the data */
:: chanin?error(vr) ->	/* got an error message */ 
     chanout!data(mt,at)	/* resend the data */
od
}

/*Receiver - with initialisation*/

proctype B (chan chanin, chanout)
{  byte mr;		/* message type */
    byte last_mr;	/* mr of last error-free msg */
    bit at;		/* status bit */
    bit last_at;		/* vr of last error-free msg */
    bit ini=0;		/* initialised */

do
:: chanin?error(mr,at) ->	/* receive corrupted msg */
     chanout!error(at)
:: chanin?data(mr,at) -> 	/* receive correct msg */
      chanout!control(at);
       if
       :: (!ini) ->	/* not initialised */
               ini = 1; last_at =at	/* initialise */	       
       :: (ini) ->	/* initialised */
               if 
              ::  (at== last_at) ->	/* retransmission, do not accept */
                  skip
               ::  (at != last_at) ->	/* new message, accept */
                   NO_ERROR;
                    last_at = at;	/* set last variables */
                    last_mr =mr
               fi
     fi
od
}	

init
{

atomic{	run A(toA, fromA);
	run B(toB, fromB);
	run lower(fromA, toA, fromB, toB)}}



	
