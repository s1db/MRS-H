chan ch = [2] of {bit};
bit x=0;
proctype A()
{do
::ch!x
::ch?x
od}

init{run A()}
