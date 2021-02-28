/* Channels of message transfer between components */
chan sensorsToSC =[0] of {mtype}
chan throttleToSC =[0] of {mtype}
chan breakToSC =[0] of {mtype}
chan wheelToSC =[0] of {int}
chan SCToWheel =[0] of {mtype, int}

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
    :: throttleToSC!faster;
    od;
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
    do
    :: (len(SCToWheel) != 0) -> SCToWheel?actionCommand,x;
        if
        :: (actionCommand==faster && x<=80) -> 
            x = x+10; wheelToSC!x;
        :: (actionCommand==slower && x>=0) -> 
            x = x-10; wheelToSC!x;
        :: (actionCommand==stop) -> 
            x = 0; wheelToSC!x;
        fi; 
    od;
}
proctype speedContol(){
    mtype acceleration = faster;
    mtype sensorState = off;
    int currentSpeed = 0;
    do
    :: (len(breakToSC) != 0) -> 
        breakToSC?acceleration;
        if
        :: (acceleration == stop) -> SCToWheel!stop,currentSpeed;
        :: (acceleration == slower) -> SCToWheel!slower,currentSpeed;
        fi;
    (len(sensorsToSC) != 0) ->
        sensorsToSC?sensorState;
        d_step{ 
            (sensorState == on && currentSpeed < 30) -> sensorState = off;
        }
    (len(throttleToSC) != 0) ->
        throttleToSC?acceleration;
        d_step{
            (sensorState == off && acceleration==faster) -> SCToWheel!faster,currentSpeed;
        }
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