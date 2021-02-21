#define N 128
#define size 16


chan in =[size] of {short};
chan large =[size] of {short};
chan small =[size] of {short};

proctype split()
{short cargo;
do
:: in?cargo->
   if
   :: (cargo>=N)->large!cargo
::(cargo<N)->small!cargo
fi
od}

proctype merge()
{short cargo;
do
::if
  ::large?cargo
::small?cargo
fi;
in!cargo
od}

init
{in!345; in!6777;in!32;in!0;
run split();run merge()}