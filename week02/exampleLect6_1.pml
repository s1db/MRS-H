int x,y;

active proctype P1(){atomic{x++;x++;}}
active proctype P2(){y++;y++;}



