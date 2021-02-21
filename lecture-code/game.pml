#define N 101
bit left[N]=1; /*records whether the number is still available*/
short total=-1;
byte x1,x2,x3,x4,x5,x6,x7,x8=0;

inline pick(x)
{if
   ::(left[1]==1)->left[1]=0;x=1
   ::(left[7]==1)->left[7]=0;x=7
   ::(left[10]==1)->left[10]=0;x=10
   ::(left[12]==1)->left[12]=0;x=12
   ::(left[15]==1)->left[15]=0;x=15
   ::(left[16]==1)->left[16]=0;x=16
   ::(left[24]==1)->left[24]=0;x=24
   ::(left[100]==1)->left[100]=0;x=100
fi}

active proctype sum()
{
pick(x1);
pick(x2);
pick(x3);
pick(x4);
pick(x5);
pick(x6);
pick(x7);
pick(x8);
total=3*x1-2*x2+1*x3-3*x4-8*x5+1*x6-9*x7-1*x8}

#define p (total==0)
#include "game.ltl"