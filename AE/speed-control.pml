/* Channels of message transfer between components */
chan sensorsToSC =[0] of {mtype};
chan throttleToSC =[0] of {mtype};
chan brakeToSC =[0] of {mtype};
chan wheelToSC =[0] of {int};
chan SCToWheel =[0] of {mtype, int};

/* Messages */
mtype = {faster, slower, stop, cruise, on, off, none}

/* Global variables defined to be used by never and speedControl only */
mtype acceleration; /* stores to messages from throttle */
mtype sensorState; /* stores messages from sensor, initalized to off */
mtype brakeState; /* stores messages from break */
int currentSpeed; /* the current speed of the car */

/* 
 * if an on message is sent from the sensors process to the speedControl process,
 * then the speed will not increase until a corresponding off message is sent
 */
active proctype monitor(){
    int sensorOnSpeed; /* speed of car when sensor is on */
    T0_monitor:
    if
    :: (sensorState == on) -> sensorOnSpeed = currentSpeed; goto T1_monitor;
    :: else -> goto T0_monitor;
    fi;
    T1_monitor:
    if
    :: (sensorState == on) -> assert(sensorOnSpeed == currentSpeed); goto T1_monitor;
    :: else -> goto T0_monitor;
    fi;
}


proctype sensors(){
    do
    :: sensorsToSC!on;
    :: sensorsToSC!off;
    od;
}

proctype throttle(){
    do
    :: throttleToSC!faster;
    :: throttleToSC!none;
    od;
}

proctype brake(){
    do
    :: brakeToSC!stop;
    :: brakeToSC!slower;
    :: brakeToSC!none;
    od;
}


proctype wheel(){
    mtype actionCommand;
    int x; /*car speed*/
    w1:
    SCToWheel?actionCommand,x;
    if
    :: (actionCommand==faster && x < 80) -> x = x+10;
    :: (actionCommand==slower && x > 0) -> x = x-10;
    :: (actionCommand==stop) -> x = 0;
    :: (actionCommand==cruise) -> skip;
    :: else -> skip; /* case when speed = 80 or speed = 0 */
    fi;
    wheelToSC!x;
    goto w1;
}

proctype speedContol(){
    sc1:
    sensorsToSC?sensorState;
    throttleToSC?acceleration;
    brakeToSC?brakeState;
    if
    :: (brakeState == stop) -> SCToWheel!stop,currentSpeed;
    :: (brakeState == slower) -> SCToWheel!slower,currentSpeed;
    :: (sensorState == off && acceleration==faster) -> SCToWheel!faster,currentSpeed;
    :: (sensorState == off && acceleration==none) -> SCToWheel!cruise,currentSpeed;
    :: (sensorState == on && acceleration==faster) -> SCToWheel!cruise,currentSpeed;
    :: (sensorState == on && acceleration==none) -> SCToWheel!cruise,currentSpeed; 
    fi;
    wheelToSC?currentSpeed;
    assert(!(currentSpeed < 0 || currentSpeed > 80))
    goto sc1;
}
init{
    atomic{
        run brake();
        run throttle();
        run sensors();
        run wheel();
        run speedContol();
    }
}
