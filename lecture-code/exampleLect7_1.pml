byte x=0;
byte y=1;

proctype A()
{

if
::(x==1)->x--;y++
::(y==1)->x++;x--
fi}

proctype monitor()
{do
::assert(((x==0)&&(y==1))||((x==1)&&(y==0)))
od
}

init{atomic{run A();run monitor()
	   }
}

