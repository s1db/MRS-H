mtype = {hammer, mallet, up, down}
chan one = [1] of {mtype};
chan two = [1] of {mtype};
chan three = [1] of {mtype};
short p1 = -1;
short p2 = -1;
short p3 = -1;



proctype worker(chan mine, a, b; bit tools)
{mtype m;
 mtype arm = up;

 idle: mine?m; 
       if	
       :: m == hammer -> tools = tools+1; goto idle
       :: m == mallet ->
          if
          :: tools == 0 ->
             if
             :: atomic {a!m; goto idle}
             :: atomic {b!m; goto idle}
             fi                                           
          :: tools == 1 ->  tools = 0; goto work
          fi
      fi;

 work:arm = down; arm = up;
      if
      :: a!hammer; a!mallet
      :: b!hammer; a!mallet
      :: a!hammer; b!mallet
      :: b!hammer;b!mallet
      :: a!mallet;a!hammer 
      :: a!mallet; b!hammer 
      :: b!mallet;a!hammer 
      ::b!mallet;b!hammer
      fi;
goto idle

}


init { 
atomic { p1 = run worker(one,two,three,0);
	p2 = run worker(two, three,one,0);
	p3 = run worker(three,one,two,0);
                one!hammer;one!mallet
            }}


#define q (worker[p1]@idle)
#define r (worker[p1]@work)

/* ltl property1 { [] (q -> <> r) }*/ 
#include "lecture11claim1.pml"

