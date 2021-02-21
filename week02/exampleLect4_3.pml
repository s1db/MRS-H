chan qname = [1] of {chan};
chan qforb = [1] of {int};
proctype A(chan q1)
{chan q2;
	q1?q2;
	q2!123}
proctype B(chan q3)
{int x;
 q3?x;
 printf("x = %d\n", x);
}
init
{run A(qname); run B(qforb);
  qname!qforb}
