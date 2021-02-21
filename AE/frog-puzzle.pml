#define N 3 //number of a single coloured from
#define MAX 20  //maximum number of moves
#define PADS 2*N+1

proctype monitor(){
    do
    :: assert((!gameOver) || (moves > MAX))
    od;
}