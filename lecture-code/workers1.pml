mtype ={hammer, up, down}
chan one= [1] of {mtype};
chan two = [1] of {mtype};
chan three= [1] of {mtype};
short p1=-1;


proctype worker(chan mine, a, b)
{mtype m;
  mtype arm = up;

  idle:   mine?m; goto work;

 work:   arm = down;
              if   :: atomic  {a!hammer;  arm = up; goto idle}
                    :: atomic {b!hammer;  arm = up; goto idle}
             fi
}

init { 
atomic {p1=run worker(one,two,three);
	run worker(two, three,one);
	run worker(three,one,two);
	one!hammer
            }
       }

#define r (worker[p1]@work)
#define q (worker[p1]@idle)


ltl property1 { [] (q -> <> r)  }


