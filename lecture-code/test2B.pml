/* example 3 */ 
chan chan1 = [1] of {mtype}; 
chan chan2 = [1] of {mtype}; 
mtype = {null,token}; 

proctype Client(chan chanin,chanout) 
{mtype message=null; 
start:chanin?message; 
assert(message==token); 
atomic{chanout!message; 
message=null; }
goto start} 

init{chan1!token; 
     run Client(chan1,chan2); 
     run Client(chan2,chan1) } 

