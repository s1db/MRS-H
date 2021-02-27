#define N 4
#define MAX 30
#define PADS 9
mtype = {null, red, yellow};
mtype state[PADS];
byte moves;

#define gameOver (\
	(state[0]==red) && \
	(state[1]==red) && \
	(state[2]==red) && \
	(state[4]==yellow)   && \
	(state[5]==yellow)   && \
	(state[6]==yellow)      \
	)

proctype monitor(){
    do
    ::
    bool gameOver1;
    int l = 0; 
    int r = 0;
    bool lgo = true;
    bool rgo = true;
    atomic{for(l : 0 .. N-1){lgo = lgo && (state[l] == red)}}
    atomic{for(r : l+1 .. PADS-1){rgo = rgo && (state[r] == yellow)}}
    gameOver1 = lgo && rgo && (state[PADS/2] == null);
    l = 0;
    r = 0;
    assert((!gameOver1) || (moves > MAX));

/* 
    assert((!gameOver) || (moves > MAX)) 
*/
    od;
 }

proctype redJumper(byte id){
    end:do
    :: atomic{
        (id > 0) && state[id-1] == null ->
        state[id-1] = red;
        state[id] = null;
        id--;
        moves++;
    }
    :: atomic{
        (id-1 > 0) && state[id-2] == null && (state[id-1] != null) ->
        state[id] = null;
        state[id-2] = red;
        id=id-2;
        moves++;
    }
    od;
}
proctype yellowJumper(byte id){
    end:do
    :: atomic{
        (id < PADS-1) && state[id+1] == null ->
        state[id] = null;
        state[id+1] = yellow;
        id=id+1;
        moves++;
    }
    :: atomic{
        (id+1 < PADS-1) && state[id+2] == null && (state[id+1] != null)->
        state[id] = null;
        state[id+2] = yellow;
        id=id+2;
        moves=moves+1;
    }
    od;
}

init{
    run monitor();
    atomic{
        state[PADS/2] = null;
        byte i = 0;
        byte l = 0;
        do
        :: (i < PADS/2) -> 
            state[i] = yellow; run yellowJumper(i);
            l = PADS-i-1;
            state[l] = red; run redJumper(l); 
            i++;
        :: else -> break;
        od;
    }
}