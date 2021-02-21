chan result =[1] of {int};
int answer;

proctype fact(int n;chan p)
/*calculate factorial n, communicating result via p */

{chan child =[1] of {int};
/*for result from fact n-1 */
   int my_result;

if
   ::(n<=1)->p!1
   ::(n>=2)->run fact(n-1,child);
child?my_result;
  p!(n*my_result)
fi
}

init /*factorial 5*/
{run fact(5,result);
result?answer;
printf("result is %d\n",answer)
}
