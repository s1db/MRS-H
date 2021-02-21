chan name = [0] of {byte};
proctype A()
{ name!124;
  name!121}
 
proctype B()
{ byte state;
   name?state }
init
{ atomic {run A(); run B()}}    
/* created without interruption */
