/*to illustrate simple race condition*/

chan chan1 = [1] of {bit};
proctype agent()
{bit x=1;
if
::empty(chan1)->chan1!x;goto winner
::full(chan1)->chan1?x;goto loser
fi;
winner:printf("I am the winner");
goto stop;
loser:printf("I am the loser");
stop:skip}

init{atomic{run agent();run agent()}}
