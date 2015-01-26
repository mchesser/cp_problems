include "alldifferent.mzn";

% The size of a the inner squares of the puzzle (for regular sudoku this is 3)
int: InnerSize;
% The total size
int: N = InnerSize * InnerSize;

% The numbers initially set, 0 => no hint
array[int, int] of int: Start;

% The complete puzzle
array[1..N, 1..N] of var 1..N: puzzle;

% Set the hints
constraint forall (i, j in 1..N where Start[i, j] != 0) (
  puzzle[i, j] = Start[i, j]
);

% Ensure that all the rows and columns contain unique numbers
constraint forall (x in 1..N) (
  alldifferent([puzzle[x, j] | j in 1..N]) /\
  alldifferent([puzzle[i, x] | i in 1..N])
);


% Ensure that the the inner squares contain unique numbers
constraint forall (x,y in 0..(InnerSize-1)) (
  alldifferent([puzzle[x*InnerSize + i, y*InnerSize + j] | i,j in 1..InnerSize])
);

solve satisfy;

% Print out the lights we need to switch
output [ show(puzzle[i,j]) ++
         if j = N then "\n" else " " endif
         | i, j in 1..N ];
