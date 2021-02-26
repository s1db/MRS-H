/* Channels of message transfer between components */
chan sensorsToSC =[0] of {mtype}
chan throttleToSC =[0] of {mtype}
chan breakToSC =[0] of {mtype}
chan SCToWheel =[0] of {mtype, int}
chan wheelToSC =[0] of {int}

/* Messages */
mtype = {faster, slower, stop, cruise, on, off}

proctype sensors(){
    do
    :: sensorsToSC!on;
    :: sensorsToSC!off;
    od;
}
proctype throttle(){
    do
    ::throttleToSC!faster;
    od
}
proctype breaks(){
    do
    :: breakToSC!slower;
    :: breakToSC!stop;
    od;
}
proctype wheel(){
    int x; /*car speed*/
    mtype actionCommand;
    SCToWheel?actionCommand,x
    do
    :: (actionCommand==faster && x<=80) -> x= x+10; wheelToSC!x;
    :: (actionCommand==slower && x>=0) -> x=x-10; wheelToSC!x;
    :: (actionCommand==stop) -> x=0; wheelToSC!x;
    od;
}
proctype speedContol(){
    mtype acceleration;
    mtype sensorState;
    int currentSpeed;

    SCToWheel!faster,10;
    wheelToSC?currentSpeed;
    do
    :: breakToSC?acceleration ->
        do
        :: (acceleration == stop) -> SCToWheel!stop,currentSpeed;
        :: (acceleration == slower) -> SCToWheel!slower,currentSpeed;
        od;
    :: sensorsToSC?sensorState -> 
        atomic{(sensorState == on && currentSpeed < 30) -> sensorState = off;}
    :: throttleToSC?acceleration ->
        atomic{(sensorState == off && acceleration==faster) -> SCToWheel!faster,currentSpeed;} 
    od;
}
init{
    atomic{
        run speedContol();
        run wheel();
        run breaks();
        run throttle();
        run sensors();
    }
}