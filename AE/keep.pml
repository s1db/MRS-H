/*
TODO:
- [ ] Create a working model that jumps b/w states.
- [ ] Go through specification to see if everything is implemented.
- [ ] Verify property in part b.
- [ ] Write report.
*/








#define N 3
#define MAX 30
#define PADS 2*N+1
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
    d_step{for(l : 0 .. N-1){lgo = lgo && (state[l] == red)}}
    d_step{for(r : l+1 .. PADS-1){rgo = rgo && (state[r] == yellow)}}
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
    :: d_step{
        (id > 0) && state[id-1] == null ->
        state[id-1] = red;
        state[id] = null;
        id--;
        moves++;
    }
    :: d_step{
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
    :: d_step{
        (id < PADS-1) && state[id+1] == null ->
        state[id] = null;
        state[id+1] = yellow;
        id=id+1;
        moves++;
    }
    :: d_step{
        (id+1 < PADS-1) && state[id+2] == null && (state[id+1] != null)->
        state[id] = null;
        state[id+2] = yellow;
        id=id+2;
        moves=moves+1;
    }
    od;
}

init{
    atomic{
        state[PADS/2] = null;
        byte i = 0;
        byte l = 0;
        run monitor();
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