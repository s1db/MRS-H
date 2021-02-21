mtype sensorsToSC = {on, off};
mtype throttleToSC = {faster};
mtype breakToSC = {slower, stop};
int wheelToSC;
chan SCToWheel = [0] of { mtype, int };