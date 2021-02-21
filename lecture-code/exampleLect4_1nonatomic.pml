int x,y;

proctype A( ){x=1;y=2}
proctype B( ){x=3}

init{ run A(); run B()}
