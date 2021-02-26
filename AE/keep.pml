/*    int li = 0;
    int ri = 0;
    bool gameOver;
    do
    /**::atomic{
        gameOver = true;
        do
        :: li < N ->
            ri = PADS-li-1;
            gameOver = gameOver && \
                    (state[PADS/2] == null) && \
                    (state[li] == red) && \
                    (state[ri] == yellow);
            li++;
        :: else -> break;
        od;
      } */
